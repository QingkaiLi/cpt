class ChangeSelectionsTitle < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :selections do |t|
        dir.up   { t.change :title, :string, :limit => 256 }
        dir.down { t.change :title, :string, :limit => 255 }
      end
    end
  end
end
