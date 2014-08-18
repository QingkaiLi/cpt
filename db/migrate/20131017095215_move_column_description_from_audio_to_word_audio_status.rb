class MoveColumnDescriptionFromAudioToWordAudioStatus < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :word_audio_statuses, :description, :string, :limit => 1024
        execute "update word_audio_statuses was set was.description = (select description from audios a where a.id = was.audio_id)"
        remove_column :audios, :description
      end

      dir.down do
        add_column :audios, :description, :string, :limit => 1024
        execute "update audios was set was.description = (select description from word_audio_statuses a where a.audio_id = was.id)"
        remove_column :word_audio_statuses, :description
      end
    end
  end
end
