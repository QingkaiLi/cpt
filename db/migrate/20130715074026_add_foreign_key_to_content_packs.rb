class AddForeignKeyToContentPacks < ActiveRecord::Migration
  def change

    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE content_packs
            ADD CONSTRAINT fk_content_packs_users FOREIGN KEY (user_id) REFERENCES users(id)
        SQL
      end

      dir.down do
        #remove a foreign key
        execute <<-SQL
          ALTER TABLE content_packs
            DROP FOREIGN KEY fk_content_packs_users
        SQL
        remove_column :content_packs, :user_id
      end
    end
  end
end
