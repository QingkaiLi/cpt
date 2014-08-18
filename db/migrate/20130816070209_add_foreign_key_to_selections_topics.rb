class AddForeignKeyToSelectionsTopics < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :selections, :topic_id, :integer
        execute <<-SQL
          ALTER TABLE selections
            ADD CONSTRAINT fk_selections_topics FOREIGN KEY (topic_id) REFERENCES topics(id)
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE selections
            DROP FOREIGN KEY fk_selections_topics
        SQL
        remove_column :selections, :topic_id
      end
    end
  end
end
