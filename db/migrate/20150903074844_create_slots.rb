class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :question_id
      t.integer :quiz_id

      t.timestamps null: false
    end
  end
end
