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

  def summary_score
    sql = "
      select
      	to_char(created_at, 'YYYY-MM') date
      	,avg(score) average
      	,(coalesce(sum(case when score >= 9 then 1 end), 0) - coalesce(sum(case when score <= 6 then -1 end), 0)) * 100 / count(*) nps
      from
      	answers
      where
      	member_id = #{self.id}
      	and score is not null
      group by
      	to_char(created_at, 'YYYY-MM')
    "
    Answer.find_by_sql(sql)
  end

end
