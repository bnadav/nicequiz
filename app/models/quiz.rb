class Quiz < ActiveRecord::Base
  has_many :slots, dependent: :destroy
  has_many :questions, through: :slots


  def to_typeform(user_id="")
    {"title": "Your Quiz!!",
     "design_id": "S2WEqhUbbc",
     "tags": [self.id.to_s, user_id.to_s],
     "fields": questions.inject([]) {|f,q| f << q.to_typeform; f}
    }
  end
end
