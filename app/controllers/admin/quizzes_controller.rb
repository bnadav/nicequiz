class Admin::QuizzesController < ApplicationController

  before_action :admin?

  def index
    @quizzes = Quiz.all
  end

  def new
    @quiz = Quiz.new
  end

  def create
    if QuizFactory.new.create(params[:quiz][:num_questions].to_i, Quiz.count)
      redirect_to admin_quizzes_url
    else 
      redirect_to new_admin_quiz_url, alert: "Failed to create quiz"
    end
  end

  private
  def admin?
    redirect_to root_url, alert: "No Permission dude" unless current_user.admin?
  end
end
