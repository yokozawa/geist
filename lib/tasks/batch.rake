namespace :batch do

  task set_answer_target: :environment do
    Rake::Task['batch:clear_answer_target'].invoke
    ids = Member.where.not(id: [3, 5, 6, 7, 12]).pluck(:id)
    Member.find_each do |m|
      others = ids.reject{|v| v == m.id}
      targets = []
      others.each do |id|
        targets << NeedAnswerMember.new(from_member_id: m.id, to_member_id: id)
      end
      NeedAnswerMember.import targets
    end
  end

  task clear_answer_target: :environment do
    NeedAnswerMember.delete_all
  end
end
