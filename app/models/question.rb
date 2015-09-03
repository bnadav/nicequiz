class Question < ActiveRecord::Base
  has_many :slots, dependent: :destroy
  has_many :quizes, through: :slots

  def to_typeform
    {
      "type": "multiple_choice",
      "question": self.text,
      "tags": [self.id.to_s],
      "choices": [
        {
          "label": self.option_1
        },
        {
          "label": self.option_2
        },
        {
          "label": self.option_3
        },
        {
          "label": self.option_4
        }
      ]
    }
  end
end
