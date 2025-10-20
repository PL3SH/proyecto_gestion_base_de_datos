class CreateEmployers < ActiveRecord::Migration[8.0]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
