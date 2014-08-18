class CreateContentPacks < ActiveRecord::Migration
  def change
    create_table :content_packs do |t|
      t.string :name
      t.string :description
      t.integer :status
      t.integer :content_type
      t.integer :user_id

      t.timestamps
    end
  end
end
