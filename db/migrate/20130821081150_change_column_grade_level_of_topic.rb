class ChangeColumnGradeLevelOfTopic < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :topics do |t|
        dir.up   { t.change :grade_level, :string, :limit => 10 }
        dir.down { t.change :grade_level, :decimal, :precision => 3, :scale => 1 }
      end
    end
  end
end
