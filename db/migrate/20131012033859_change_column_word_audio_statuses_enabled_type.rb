class ChangeColumnWordAudioStatusesEnabledType < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :word_audio_statuses do |t|
        dir.up   { t.change :enabled, :boolean }
        dir.down { t.change :enabled, :integer }
      end
    end
  end
end
