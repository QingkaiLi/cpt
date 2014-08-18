class AddColumnToWords < ActiveRecord::Migration
  def change
    add_column :words, :text, :string, :limit => 256
    add_column :words, :alt_text, :string, :limit => 1024
    add_column :words, :word_audio_status_id, :integer
  end
end
