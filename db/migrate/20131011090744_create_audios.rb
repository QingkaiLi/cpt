class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :file_name, :null => false, :limit => 256
      t.binary :audio
      t.string :description, :limit => 1024
      t.string :hash

      t.timestamps
    end
  end
end
