class RemoveStatusFromContentPacks < ActiveRecord::Migration
  def change
    remove_column :content_packs, :status
  end
end
