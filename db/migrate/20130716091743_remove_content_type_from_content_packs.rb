class RemoveContentTypeFromContentPacks < ActiveRecord::Migration
  def change
    remove_column :content_packs, :content_type
  end
end
