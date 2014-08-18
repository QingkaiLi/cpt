class AddIndexSpellingToWordAudioStatuses < ActiveRecord::Migration
  def change
    add_index :word_audio_statuses, :spelling
  end
end
