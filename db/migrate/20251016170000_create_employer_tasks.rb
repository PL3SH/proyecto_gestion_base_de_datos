class CreateEmployerTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :employer_tasks do |t|
      t.references :employer, null: false, foreign_key: { on_delete: :cascade }
      t.references :task, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
