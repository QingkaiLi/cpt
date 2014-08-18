class ChangeForeignKeyStatusToAudioStatus < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :word_audio_statuses, :audio_status_id, :integer
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            DROP FOREIGN KEY fk_word_audio_statuses_statuses
          SQL
        remove_column :word_audio_statuses, :status_id
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            ADD CONSTRAINT fk_word_audio_statuses_audio_statuses FOREIGN KEY (audio_status_id) REFERENCES audio_statuses(id)
        SQL
      end
      
      dir.down do
        case connection.adapter_name
        when /mysql/i
          execute <<-SQL
            ALTER TABLE word_audio_statuses
              DROP FOREIGN KEY fk_word_audio_statuses_audio_statuses
            SQL
        else
          execute "ALTER TABLE word_audio_statuses DROP CONSTRAINT fk_word_audio_statuses_audio_statuses"
        end
        add_column :word_audio_statuses, :status_id, :integer
        remove_column :word_audio_statuses, :audio_status_id
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            ADD CONSTRAINT fk_word_audio_statuses_statuses FOREIGN KEY (status_id) REFERENCES statuses(id)   
        SQL
      end
    end
    
  end
end
