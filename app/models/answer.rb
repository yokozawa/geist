class Answer < ActiveRecord::Base
  belongs_to :member
  belongs_to :question

  # validates :score, presence: true
  # validates :body, presence: true

  scope :mine, -> (member) {
    where(member_id: member.id)
  }

end
