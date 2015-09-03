module ApplicationHelper
  def score_for_quiz(quiz)
    attempts = @user_previous_attempts.reject {|a| a.quiz_id != quiz.id}
    # attempts.any? ? attempts.max{|a,b| a.score <=> b.score}.score : "--"
    if attempts.any? 
      attempts.max{|a,b| a.score <=> b.score}.score.to_s + " / " + quiz.num_questions.to_s 
    else
      "--"
    end
  end
end
