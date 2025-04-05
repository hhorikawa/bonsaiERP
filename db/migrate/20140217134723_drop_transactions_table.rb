class DropTransactionsTable < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      drop_table :transactions
    end
  end

  def down
    puts 'Nothing to do with table transactions'
  end
end
