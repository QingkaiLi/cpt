class ChangeForeignKeyStatusToAudioStatusToPronunciation < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :pronunciations, :audio_status_id, :integer
        remove_column :pronunciations, :status_id
        execute <<-SQL
          ALTER TABLE pronunciations
            ADD CONSTRAINT fk_pronunciations_audio_statuses FOREIGN KEY (audio_status_id) REFERENCES audio_statuses(id)
        SQL
      end
      
      dir.down do
        case connection.adapter_name
        when /mysql/i
          execute <<-SQL
            ALTER TABLE pronunciations
              DROP FOREIGN KEY fk_pronunciations_audio_statuses
            SQL
        else
          execute "ALTER TABLE pronunciations DROP CONSTRAINT fk_pronunciations_audio_statuses"
        end
        add_column :pronunciations, :status_id, :integer
        remove_column :pronunciations, :audio_status_id
      end
    end
  end
end
