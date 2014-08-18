class AddForeignKeyToSelectionsUsers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :selections, :updater_id, :integer
        execute "update selections set updater_id = (select id from users where users.name = selections.update_by limit 1)"
        remove_column :selections, :update_by
        execute <<-SQL
          ALTER TABLE selections
            ADD CONSTRAINT fk_selections_users FOREIGN KEY (updater_id) REFERENCES users(id)
        SQL
      end

      dir.down do
        case connection.adapter_name
        when /mysql/i
          execute <<-SQL
            ALTER TABLE selections
              DROP FOREIGN KEY fk_selections_users
            SQL
        else
          execute "ALTER TABLE selections DROP CONSTRAINT fk_selections_users"
        end
        add_column :selections, :update_by, :string
        execute "update selections set update_by = (select name from users where users.id = selections.updater_id limit 1)"
        remove_column :selections, :updater_id
      end
    end
  end
end
