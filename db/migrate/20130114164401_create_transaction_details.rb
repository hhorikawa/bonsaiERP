class CreateTransactionDetails < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      create_table :transaction_details do |t|
        # parent
        t.references :order, null:false, foreign_key:true

        # 仕入れかサービスかどちらか. nullable
        t.references :item, foreign_key:true
        t.references :account, foreign_key:true
        
        t.decimal :quantity, :precision => 14, :scale => 2, default: 0.0
        t.decimal :price, :precision => 14, :scale => 2, default: 0.0
        t.string :description
        t.decimal :discount, :precision => 14, :scale => 2, default: 0.0
        t.decimal :balance, :precision => 14, :scale => 2, default: 0.0

        t.decimal  :original_price, :precision => 14, :scale => 2, default: 0.0
        t.timestamps
      end

      #add_index :transaction_details, :account_id
      #add_index :transaction_details, :item_id
    end
  end
end
