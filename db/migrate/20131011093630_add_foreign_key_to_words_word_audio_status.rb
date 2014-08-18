class AddForeignKeyToWordsWordAudioStatus < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE words
            ADD CONSTRAINT fk_words_word_audio_statuses FOREIGN KEY (word_audio_status_id) REFERENCES word_audio_statuses(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE words
            DROP FOREIGN KEY fk_words_word_audio_statuses
        SQL
      end
    end
  end
end
