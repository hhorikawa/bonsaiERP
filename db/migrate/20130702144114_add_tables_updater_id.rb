class AddTablesUpdaterId < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      change_table :account_ledgers do |t|
        t.integer :updater_id #, foreign_key: {to_table: :users}
        #add_index :account_ledgers, :updater_id
      end
      
      change_table :accounts do |t|
        # nullable
        t.integer :updater_id  #, foreign_key: {to_table: :users}
        #add_index :accounts, :updater_id
      end

      change_table :inventories do |t|
        t.integer :updater_id  #, foreign_key: {to_table: :users}
        #add_index :inventories, :updater_id
      end
    end
  end

  def down
    PgTools.with_schemas except: 'common' do
      remove_column :account_ledgers, :updater_id
      remove_column :accounts, :updater_id
      remove_column :inventories, :updater_id
    end
  end
end
