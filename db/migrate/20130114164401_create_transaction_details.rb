
# order の 1行
class CreateTransactionDetails < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      create_table :transaction_details do |t|
        # parent
        t.references :order, null:false, foreign_key:true

        # 仕入れかサービスかどちらか. nullable
        t.references :item, foreign_key:true
        t.references :account, foreign_key:true

        # item の場合 qty 必須. account の場合も (qty * price)
        t.decimal :quantity, precision: 14, scale: 2, null:false, default: 0.0
        t.decimal :price, precision: 14, scale: 2, null:false, default: 0.0
        
        t.string :description, null:false
        
        #t.decimal  :original_price, :precision => 14, :scale => 2, default: 0.0
        #t.decimal :discount, :precision => 14, :scale => 2, default: 0.0

        # 最初: balance = qty, 納品完了: balance = 0
        # なので, 伝票内で item は unique でないといけない
        t.decimal :balance, precision: 14, scale: 2, null:false, default: 0.0

        t.timestamps
      end
      add_index :transaction_details, [:order_id, :item_id], unique:true
      #add_index :transaction_details, :account_id
      #add_index :transaction_details, :item_id
    end
  end
end
