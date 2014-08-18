class DropContentPacks < ActiveRecord::Migration
  def change
    drop_table :content_packs if table_exists? :content_packs
  end
end
