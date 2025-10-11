class AddIncomesExpensesStatusOnContacts < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      change_table :contacts do |t|
        t.remove :money_status
        t.jsonb :incomes_status, default: '{}' #, limit: 300
        t.jsonb :expenses_status, default: '{}' #, limit: 300
      end
    end
  end

  def down
    PgTools.with_schemas except: 'common' do
      change_table :contacts do |t|
        t.string :money_status
        t.remove :incomes_status
        t.remove :expenses_status
      end
    end
  end
end
