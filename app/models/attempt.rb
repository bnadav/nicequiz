class Attempt < ActiveRecord::Base
  include Comparable
  belongs_to :quiz
  belongs_to :user

  API = "bb95d477579e1bb7ecb8241b18903ec0"; 
  #URL = "https://api.typeform.io/v0.4/forms"
  URL = "https://api.typeform.io/latest/forms"

  NGROK_URL = "http://ae154f3a.ngrok.io"
 
  RESPONSE_ENDPOINT = NGROK_URL + "/attempts"


  def <=>(a,b)
    a.score <=> b.score
  end

  def prepare(quiz, user)
    RestClient.post URL, 
      quiz.to_typeform(user.id).
       merge!({webhook_submit_url: RESPONSE_ENDPOINT}).to_json, 
      :content_type => :json, :accept => :json, "X-API-TOKEN" => API
  end

  def calc_score!(answers)
   correct_responses = self.quiz.questions.reject do |q|
     #correct_response = (q.send "option_#{q.correct_option}")
     #puts "REPORTED ANSWER #{answers[q.id.to_s]} CORRECT ONE #{correct_response}"
     answers[q.id.to_s] != (q.send "option_#{q.correct_option}")
   end
   self.score = correct_responses.size
   save!
  end
end
