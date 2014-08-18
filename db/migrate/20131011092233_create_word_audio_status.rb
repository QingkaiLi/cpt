class CreateWordAudioStatus < ActiveRecord::Migration
  def change
    create_table :word_audio_statuses do |t|
      t.string :spelling, :null => false, :limit => 256
      t.integer :audio_id
      t.integer :status_id
      t.integer :enabled
            
      t.timestamps
    end
  end
end
