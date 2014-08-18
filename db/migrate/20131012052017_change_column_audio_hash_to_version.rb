class ChangeColumnAudioHashToVersion < ActiveRecord::Migration
  def change
     rename_column :audios, :hash, :version
  end
end
