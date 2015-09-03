class AttemptsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :fetch_user, :fetch_quiz, :fetch_answers, only: :create

  def index
    @all_quizzes = Quiz.all
    @user_previous_attempts = User.last.attempts
  end

  def new
    quiz = Quiz.find(params[:quiz_id])
    typeform_response = Attempt.new.prepare(quiz, User.last)
    @link = JSON.parse(typeform_response)["_links"].find{|h| h["rel"] == "form_render"}["href"]
    render  layout: false
  end
  
  def create
    attempt = Attempt.create!(user: @user, quiz: @quiz)
    attempt.calc_score!(@answers)
    redirect_to attempts_url
  end

  private
  def fetch_user
    @user = User.find(params[:tags].last)
  end

  def fetch_quiz
    @quiz = Quiz.find(params[:tags].first)
  end

  def fetch_answers
    @answers = params[:answers].inject({}) do |hsh, answer_data|
      hsh[answer_data["tags"].first] = answer_data[:value][:label]
      hsh
    end
  end
end
