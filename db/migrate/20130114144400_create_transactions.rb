class CreateTransactions < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do

      create_table :orders do |t|
        #t.integer :account_id

        # STI は `type` が必要
        t.string :type, limit:80, null:false
        
        # Use Account#amount for total, create alias
        t.decimal :total, precision: 14, scale: 2, null:false, default: 0.0

        # Use Account#name for ref_number create alias
        t.string  :bill_number

        t.decimal :gross_total, precision: 14, scale: 2, default: 0.0
        t.decimal :original_total, precision: 14, scale: 2, default: 0.0
        t.decimal :balance_inventory, precision: 14, scale: 2, default: 0.0

        t.date    :due_date
        # Creators approver
        t.integer  :creator_id
        t.integer  :approver_id
        t.integer  :nuller_id
        t.datetime :nuller_datetime
        t.string   :null_reason, limit: 400
        t.datetime :approver_datetime

        t.boolean :delivered, null:false, default: false
        t.boolean :discounted, null:false, default: false
        t.boolean :devolution, null:false, default: false

        t.timestamps
      end

      #add_index :transactions, :account_id, unique: true
      #add_index :transactions, :due_date
      #add_index :transactions, :delivered
      #add_index :transactions, :discounted
      #add_index :transactions, :devolution
      #add_index :transactions, :bill_number
    end
  end
end
