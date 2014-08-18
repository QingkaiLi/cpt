class DropUsers < ActiveRecord::Migration
  def change
    drop_table :users if table_exists? :users
  end
end
