require 'rest-client'

class QuizFactory
  URL = "https://pareshchouhan-trivia-v1.p.mashape.com/v1"
  API_KEY = "DGUULjKxWmmshhS13T7Oie3yMD9Cp1onmdvjsnpSmt4CuiTghi"
  attr_reader :url, :api_key

  def initialize(url=URL, key=API_KEY)
    @url = url
    @api_key = key
  end

  def create(length, disposition)
    save(fetch(length,disposition))
  end

  #private
  # Return a json object describing the quiz
  def fetch(length, disposition)
    response = RestClient::Request.execute(method: 'get',
                                url: "#{url}/getAllQuizQuestions",
                                headers: {params: {limit: length, page: disposition},
                                          "X-Mashape-Key" => api_key,
                                          :accept => :json})

    response.body
  end

  def save(json)
    quiz_data = JSON.parse(json)
    ActiveRecord::Base.transaction do
      quiz = Quiz.create(num_questions: quiz_data.size)
      quiz_data.each do |record|
        question = Question.find_or_create_by(
          text: record["q_text"],
          option_1: record["q_options_1"],
          option_2: record["q_options_2"],
          option_3: record["q_options_3"],
          option_4: record["q_options_4"],
          correct_option: record["q_correct_option"],
          difficulty: record["q_difficulty_level"]
        )
        Slot.create(quiz: quiz, question: question)
      end
    end
    quiz
  end


end

