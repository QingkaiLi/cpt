class CreateContentTypes < ActiveRecord::Migration
  def change
    create_table :content_types do |t|
      t.string :name
    end

    reversible do |dir|
      dir.up do
        add_column :content_packs, :content_type_id, :integer
        #add a foreign key
        execute <<-SQL
          ALTER TABLE content_packs
            ADD CONSTRAINT fk_content_packs_content_types FOREIGN KEY (content_type_id) REFERENCES content_types(id)
        SQL
      end

      dir.down do
        #remove a foreign key
        execute <<-SQL
          ALTER TABLE content_packs
            DROP FOREIGN KEY fk_content_packs_content_types
        SQL
        remove_column :content_packs, :content_type_id
      end
    end
  end
end
