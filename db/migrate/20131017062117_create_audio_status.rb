class CreateAudioStatus < ActiveRecord::Migration
  def change
    create_table :audio_statuses do |t|
       t.string :name
    end
  end
end
