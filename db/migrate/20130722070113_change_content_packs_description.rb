class ChangeContentPacksDescription < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :content_packs do |t|
        dir.up   { t.change :description, :string, :limit => 1024 }
        dir.down { t.change :description, :string, :limit => 255 }
      end
    end
  end
end
