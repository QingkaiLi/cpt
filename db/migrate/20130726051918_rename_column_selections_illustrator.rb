class RenameColumnSelectionsIllustrator < ActiveRecord::Migration
  def change
     rename_column :selections, :illustartor, :illustrator
  end
end
