class AddForeignKeyToWordAudioStatusStatuses < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            ADD CONSTRAINT fk_word_audio_statuses_statuses FOREIGN KEY (status_id) REFERENCES statuses(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            DROP FOREIGN KEY fk_word_audio_statuses_statuses
        SQL
      end
    end
  end
end
