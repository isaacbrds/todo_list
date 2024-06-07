class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name, limit: 50
      t.string :description, limit: 140
      t.boolean :completed, null: false, default: false
      t.date :due_date
      t.integer :priority, null: false, default: 0
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
