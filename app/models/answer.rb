class Answer < ActiveRecord::Base
  belongs_to :member
  belongs_to :question

  # validates :score, presence: true
  # validates :body, presence: true

  scope :mine, -> (member) {
    where(member_id: member.id)
  }

  def summary_score
    sql = "
      select
      	to_char(created_at, 'YYYY-MM') date
      	,avg(score) average
      	,(coalesce(sum(case when score >= 9 then 1 end), 0) - coalesce(sum(case when score <= 6 then -1 end), 0)) * 100 / count(*) nps
      from
      	answers
      where
      	member_id = #{self.member_id}
      	and score is not null
      group by
      	to_char(created_at, 'YYYY-MM')
    "
    Answer.find_by_sql(sql)
  end


end
