class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :score
      t.integer :user_id
      t.integer :quiz_id

      t.timestamps null: false
    end
  end
end
