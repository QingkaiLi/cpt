class AddIndexSpellingAudioToWordAudioStatuses < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_index(:word_audio_statuses, [:spelling, :audio_id], unique: true, name: :idx_spelling_audio_id)
      end

      dir.down do
        remove_index :word_audio_statuses, name: :idx_spelling_audio_id
      end
    end
  end
end
