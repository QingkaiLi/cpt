class AddForeignKeyToWordAudioStatusAudios < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            ADD CONSTRAINT fk_word_audio_statuses_audios FOREIGN KEY (audio_id) REFERENCES audios(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            DROP FOREIGN KEY fk_word_audio_statuses_audios
        SQL
      end
    end
  end
end
