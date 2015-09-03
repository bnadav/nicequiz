module ApplicationHelper
  def score_for_quiz(quiz)
    attempt = @user_previous_attempts.find {|a| a.quiz_id == quiz.id}
    attempt ? attempt.score : ""
  end
end
