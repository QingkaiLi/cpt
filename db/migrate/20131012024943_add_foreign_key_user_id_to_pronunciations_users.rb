class AddForeignKeyUserIdToPronunciationsUsers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :pronunciations, :user_id, :integer
        execute <<-SQL
          ALTER TABLE pronunciations
            ADD CONSTRAINT fk_pronunciations_users FOREIGN KEY (user_id) REFERENCES users(id)
        SQL
      end

      dir.down do
        #remove a foreign key
        execute <<-SQL
          ALTER TABLE pronunciations
            DROP FOREIGN KEY fk_pronunciations_users
        SQL
        remove_column :pronunciations, :user_id
      end
    end
  end
end
