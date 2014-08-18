class AddColumnPriorityToSelections < ActiveRecord::Migration
  def change
    add_column :selections, :priority, :integer
  end
end
