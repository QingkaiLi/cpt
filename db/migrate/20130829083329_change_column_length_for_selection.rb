class ChangeColumnLengthForSelection < ActiveRecord::Migration
  def up
    change_table :selections do |t|
      t.change :author, :string, :limit => 256
      t.change :illustrator, :string, :limit => 256
      t.change :publisher, :string, :limit => 256
      t.change :intro_text, :string, :limit => 1024
      t.change :intro_audio, :string, :limit => 1024
    end
  end
 
  def down
    change_table :selections do |t|
      t.change :author, :string, :limit => 255
      t.change :illustrator, :string, :limit => 255
      t.change :publisher, :string, :limit => 255
      t.change :intro_text, :string, :limit => 255
      t.change :intro_audio, :string, :limit => 255
    end
  end
end
