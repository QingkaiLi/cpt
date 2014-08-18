class ChangeTopicsName < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :topics do |t|
        dir.up   { t.change :name, :string, :limit => 256 }
        dir.down { t.change :name, :string, :limit => 255 }
      end
    end
  end
end
