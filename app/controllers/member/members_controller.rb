class Member::MembersController < Member::AppController
  def new_answers
    @member = Member.find_by_id(params[:member_id])
    Question.all.each do |q|
      @member.answers.build(question: q)
    end
  end

  def create_answers
    answers = []
    create_answers_params[:answers_attributes].to_h.values.each do |answer_param|
      answers << Answer.new(answer_param.merge({member_id: params[:member_id]}))
    end

    if Answer.import answers
      # TODO レコード削除
      NeedAnswerMember.where(from_member: current_member)
        .where(to_member: params[:member_id]).delete_all
      redirect_to mypage_path, notice: "回答を入力しました"
    else
      format.html { render :new_answers }
    end
  end

  def show
    @questions = Question.all.each do |q|
      q.my_answers = current_member.answers.where(question_id: q.id)
    end
  end

  private
    def create_answers_params
      params[:member].permit(answers_attributes: [:question_id, :score, :body])
    end
end
