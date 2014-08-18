class CreateStatus < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
    end

    reversible do |dir|
      dir.up do
        add_column :content_packs, :status_id, :integer
        #add a foreign key
        execute <<-SQL
          ALTER TABLE content_packs
            ADD CONSTRAINT fk_content_packs_statuses FOREIGN KEY (status_id) REFERENCES statuses(id)
        SQL
      end

      dir.down do
        #remove a foreign key
        execute <<-SQL
          ALTER TABLE content_packs
            DROP FOREIGN KEY fk_content_packs_statuses
        SQL
        remove_column :content_packs, :status_id
      end
    end
  end
end
