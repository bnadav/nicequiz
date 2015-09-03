class AddLinkToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :link, :string
  end
end
