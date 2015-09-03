class Admin::QuizzesController < ApplicationController

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
      render :new, alert: "Failed to create quiz"
    end
  end
end
