class CreateTransactions < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do

      create_table :orders do |t|
        # STI は `type` が必要
        t.string :type, limit:80, null:false

        t.date :date, null:false

        t.references :contact, null:false, foreign_key:true

        t.column :currency, "CHAR(3) NOT NULL"
        
        # Use Account#amount for total, create alias
        t.decimal :total, precision: 14, scale: 2, null:false, default: 0.0

        # Use Account#name for ref_number create alias
        t.string  :bill_number

        t.decimal :gross_total, precision: 14, scale: 2, default: 0.0
        t.decimal :original_total, precision: 14, scale: 2, default: 0.0
        t.decimal :balance_inventory, precision: 14, scale: 2, default: 0.0

        t.date    :due_date
        # Creators approver
        t.integer  :creator_id, null:false #, foreign_key:{to_table: :users}
        t.integer  :approver_id  #, foreign_key:{to_table: :users}
        t.datetime :approver_datetime
        
        t.integer  :nuller #, foreign_key:{to_table: :users}
        t.datetime :nuller_datetime
        t.string   :null_reason, limit: 400

        t.boolean :delivered, null:false, default: false
        t.boolean :discounted, null:false, default: false
        t.boolean :devolution, null:false, default: false

        t.string :state, limit:50, null:false
        
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
