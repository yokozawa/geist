class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :need_answer_members, class_name: :NeedAnswerMember, foreign_key: :from_member_id
  has_many :to_members, through: :need_answer_members
  has_many :wait_answer_list, class_name: :NeedAnswerMember, foreign_key: :to_member_id
  has_many :answers
  accepts_nested_attributes_for :answers
end
