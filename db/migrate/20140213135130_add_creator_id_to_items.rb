class AddCreatorIdToItems < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      change_table :items do |t|
        t.integer :creator_id, null:false
        t.index :creator_id
      end
    end
  end

  def down
    PgTools.with_schemas except: 'common' do
      remove_index :items, :creator_id
      remove_column :items, :creator_id
    end
  end
end
