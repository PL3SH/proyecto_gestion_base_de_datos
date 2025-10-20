class DropStatusTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :statuses
  end
end
