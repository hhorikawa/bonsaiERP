class AddTransactionsNoInventory < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      change_table :orders do |t|
        t.boolean :no_inventory, null:false, default: false
      end

      #add_index :transactions, :no_inventory
    end
  end

  def down
    PgTools.with_schemas except: 'common' do
      change_table :transactions do |t|
        t.remove :no_inventory
      end
    end
  end
end
