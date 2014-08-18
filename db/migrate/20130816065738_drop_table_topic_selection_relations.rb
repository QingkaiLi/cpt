class DropTableTopicSelectionRelations < ActiveRecord::Migration
  # def change
    
    # reversible do |dir|
      # dir.up do
        # case connection.adapter_name
          # when /mysql/i
            # execute <<-SQL
              # ALTER TABLE topic_selection_relations
                # DROP FOREIGN KEY fk_topic_selection_relations_selections
              # SQL
            # execute <<-SQL
              # ALTER TABLE topic_selection_relations
                # DROP FOREIGN KEY fk_topic_selection_relations_topics
              # SQL
          # else
             # for c in %[fk_topic_selection_relations_selections fk_topic_selection_relations_topics]
               # execute "ALTER TABLE topic_selection_relations DROP CONSTRAINT #{c}"
             # end
          # end
      # end
# 
      # dir.down do
        # execute <<-SQL
          # ALTER TABLE topic_selection_relations
            # ADD CONSTRAINT fk_topic_selection_relations_selections FOREIGN KEY (selection_id) REFERENCES selections(id)
        # SQL
        # execute <<-SQL
          # ALTER TABLE topic_selection_relations
            # ADD CONSTRAINT fk_topic_selection_relations_topics FOREIGN KEY (topic_id) REFERENCES topics(id)
        # SQL
      # end
    # end
    
    
     def up
        drop_table :topic_selection_relations
      end
     
      def down
        create_table :topic_selection_relations do |t|
          t.integer :topic_id
          t.integer :selection_id
          t.integer :priority
    
          t.timestamps
        end
        
        execute <<-SQL
          ALTER TABLE topic_selection_relations
            ADD CONSTRAINT fk_topic_selection_relations_selections FOREIGN KEY (selection_id) REFERENCES selections(id)
        SQL
        execute <<-SQL
          ALTER TABLE topic_selection_relations
            ADD CONSTRAINT fk_topic_selection_relations_topics FOREIGN KEY (topic_id) REFERENCES topics(id)
        SQL
     end
  # end
end
