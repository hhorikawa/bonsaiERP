class AddItemsBuyPrice < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      change_table :items do |t|
        t.decimal :buy_price, precision: 14, scale: 2, null:false, default: 0.0
      end
    end
  end

  def down
    PgTools.with_schemas except: 'common' do
      change_table :items do |t|
        t.remove :buy_price
      end
    end
  end
end
