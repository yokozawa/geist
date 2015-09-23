class Question < ActiveRecord::Base

  belongs_to :answer
  has_many :answers

  enum question_type: {
    text: 1,
    radio_5: 2,
  }
  USE_TYPE_LABELS = {
    "自由入力" => :text,
    "５段階評価" => :radio_5,
  }

  attr_accessor :my_answers

end
