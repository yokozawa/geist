class Answer < ActiveRecord::Base
  belongs_to :member
  belongs_to :question

  scope :mine, -> (member) {
    where(member_id: member.id)
  }

end
