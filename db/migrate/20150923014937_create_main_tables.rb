class CreateMainTables < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :question_type, limit: 1, null: false, default: 1
      t.string  :subtitle

      t.timestamps
    end
    create_table :answers do |t|
      t.belongs_to :member, index: true
      t.belongs_to :question, index: true
      t.integer :score, limit: 1
      t.string  :body

      t.timestamps
    end
    create_table :need_answer_members do |t|
      t.integer :from_member_id, null: false
      t.integer :to_member_id, null: false

      t.timestamps
    end
    add_index :need_answer_members, :from_member_id
    add_index :need_answer_members, :to_member_id
  end
end
