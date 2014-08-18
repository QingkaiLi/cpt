class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.string :title, :null => false, :limit => 255
      t.string :grade_equivalent_level
      t.string :lexile_level
      t.string :guided_reading_level
      t.integer :wcpm_target
      t.boolean :internationally
      t.string :description, :limit => 1024
      t.string :cover_image
      t.string :author
      t.string :illustartor
      t.string :publisher
      t.string :intro_text
      t.string :intro_audio
      t.string :update_by
      t.boolean :error
      
      t.integer :topic_id
      t.integer :status_id

      t.timestamps
    end
   
   reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE selections
            ADD CONSTRAINT fk_selections_topics FOREIGN KEY (topic_id) REFERENCES topics(id)
        SQL
        execute <<-SQL
          ALTER TABLE selections
            ADD CONSTRAINT fk_selections_statuses FOREIGN KEY (status_id) REFERENCES statuses(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE selections
            DROP FOREIGN KEY fk_selections_topics
        SQL
        execute <<-SQL
          ALTER TABLE selections
            DROP FOREIGN KEY fk_selections_statuses
        SQL
        
      end
    end
  end

end
