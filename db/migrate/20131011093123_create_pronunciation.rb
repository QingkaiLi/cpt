class CreatePronunciation < ActiveRecord::Migration
  def change
    create_table :pronunciations do |t|
      t.string :dictionary_key, :null => false, :limit => 256
      t.string :pronunciation, :limit => 512
      t.integer :status_id
            
      t.timestamps
    end
  end
end
