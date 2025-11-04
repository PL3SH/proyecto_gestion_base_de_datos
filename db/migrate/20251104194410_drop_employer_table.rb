class DropEmployerTable < ActiveRecord::Migration[8.0]
  def change
    
    drop_table :employer_tasks
    drop_table :employers
    
  end
end
