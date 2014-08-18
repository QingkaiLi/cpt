class CreateTopicSelectionRelations < ActiveRecord::Migration
  def change
   
    create_table :topic_selection_relations do |t|
      t.integer :topic_id
      t.integer :selection_id
      t.integer :priority

      t.timestamps
    end
 
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE topic_selection_relations
            ADD CONSTRAINT fk_topic_selection_relations_selections FOREIGN KEY (selection_id) REFERENCES selections(id)
        SQL
        execute <<-SQL
          ALTER TABLE topic_selection_relations
            ADD CONSTRAINT fk_topic_selection_relations_topics FOREIGN KEY (topic_id) REFERENCES topics(id)
        SQL
        # remove selcetion foreign key
        case connection.adapter_name
        when /mysql/i
          execute <<-SQL
          ALTER TABLE selections
            DROP FOREIGN KEY fk_selections_topics
          SQL
        else
          execute <<-SQL
          ALTER TABLE selections
            DROP CONSTRAINT fk_selections_topics
          SQL
        end
        remove_column :selections, :topic_id
      end

      dir.down do
        case connection.adapter_name
        when /mysql/i
          execute <<-SQL
            ALTER TABLE topic_selection_relations
              DROP FOREIGN KEY fk_topic_selection_relations_selections
            SQL
          execute <<-SQL
            ALTER TABLE topic_selection_relations
              DROP FOREIGN KEY fk_topic_selection_relations_topics
            SQL
        else
           for c in %[fk_topic_selection_relations_selections fk_topic_selection_relations_topics]
             execute "ALTER TABLE topic_selection_relations DROP CONSTRAINT #{c}"
           end
        end
        #rollback
        # XXXhau: can't really do this because topic association is lost
        add_column :selections, :topic_id, :integer
        execute <<-SQL
          ALTER TABLE selections
            ADD CONSTRAINT fk_selections_topics FOREIGN KEY (topic_id) REFERENCES topics(id)
        SQL
      end
    end
  end
end
