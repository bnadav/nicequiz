module ApplicationHelper
  def score_for_quiz(quiz)
    attempts = @user_previous_attempts.reject {|a| a.quiz_id != quiz.id}
    attempts.any? ? attempts.max{|a,b| a.score <=> b.score}.score : ""
  end
end
