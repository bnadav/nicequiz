class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :num_questions
      t.integer :category_id
      t.float :average_difficulty

      t.timestamps null: false
    end
  end
end
