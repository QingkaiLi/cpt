class AddForeignKeyUserIdToWordAudioStatusesUsers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :word_audio_statuses, :user_id, :integer
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            ADD CONSTRAINT fk_word_audio_statuses_users FOREIGN KEY (user_id) REFERENCES users(id)
        SQL
      end

      dir.down do
        #remove a foreign key
        execute <<-SQL
          ALTER TABLE word_audio_statuses
            DROP FOREIGN KEY fk_word_audio_statuses_users
        SQL
        remove_column :word_audio_statuses, :user_id
      end
    end
  end
end
