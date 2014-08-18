class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, :null => false, :limit => 255
      t.decimal :grade_level, precision: 3, scale: 1
      t.boolean :default 
      t.integer :content_pack_id

      t.timestamps
    end

  reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE topics
            ADD CONSTRAINT fk_topics_content_packs FOREIGN KEY (content_pack_id) REFERENCES content_packs(id)
        SQL
      end

      dir.down do
        #remove a foreign key
        execute <<-SQL
          ALTER TABLE topics
            DROP FOREIGN KEY fk_topics_content_packs
        SQL
      end
    end

  end
end
