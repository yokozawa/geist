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

    validate = true
    answers.each do |answer|
      validate = answer.validate
    end

    if validate
      ActiveRecord::Base.transaction do
        Answer.import answers
        NeedAnswerMember.where(from_member: current_member)
          .where(to_member: params[:member_id]).delete_all
      end
      redirect_to mypage_path, notice: "回答を入力しました"
    else
      new_answers
      flash[:notice] = "入力必須です"
      render :new_answers
    end
  end

  def show
    @questions = Question.all.each do |q|
      q.my_answers = current_member.answers.where(question_id: q.id).order("id DESC")
    end
    @my_scores = current_member.summary_score
  end

  private
    def create_answers_params
      params[:member].permit(answers_attributes: [:question_id, :score, :body])
    end
end
