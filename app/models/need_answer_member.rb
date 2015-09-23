class NeedAnswerMember < ActiveRecord::Base
  belongs_to :from_member, class_name: :Member, foreign_key: :from_member_id
  belongs_to :to_member, class_name: :Member, foreign_key: :to_member_id
end
