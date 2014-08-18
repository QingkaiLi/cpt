class ChangeColumnsForAudioRespository < ActiveRecord::Migration
  def change
    rename_column :pronunciations, :pronunciation, :phonemes
    
    reversible do |dir|
      change_table :words do |t|
        dir.up { t.change :text, :string, :limit => 255 }
        dir.down { t.change :text, :string, :limit => 256 }
      end
      
      change_table :audios do |t|
        dir.up { t.change :file_name, :string, :null => false, :limit => 255 }
        dir.down { t.change :file_name, :string, :null => false, :limit => 256 }
      end
      
      change_table :word_audio_statuses do |t|
        dir.up { t.change :spelling, :string, :null => false, :limit => 255 }
        dir.down {t.change :spelling, :string, :null => false, :limit => 256 }
      end
      
      change_table :pronunciations do |t|
        dir.up { t.change :dictionary_key, :string, :null => false, :limit => 255 }
        dir.down {t.change :dictionary_key, :string, :null => false, :limit => 256 }
      end
    end
  end
end
