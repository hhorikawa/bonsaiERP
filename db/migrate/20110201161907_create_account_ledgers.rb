class CreateAccountLedgers < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do

      # 仕訳の1行
      create_table :account_ledgers do |t|
        t.date :date, null:false
        t.string   :reference
        t.string   :operation, limit: 20, null:false

        # 例えば, 勘定科目は円で, 外貨債務の支払いがある。
        t.references :account, null:false, foreign_key:true
        
        # 仕訳は2行以上
        #t.integer  :account_to_id
        #t.decimal  :account_to_balance, precision: 14, scale: 2, default: 0.0

        # "調停". 何だろう?
        t.boolean :conciliation, null:false, default: true

        # 取引金額, 取引通貨
        t.decimal :amount, precision: 14, scale: 2, null:false, default: 0.0,
                           comment: "借方がプラス"
        t.column  :currency, "CHAR(3) NOT NULL", comment: "取引通貨"

        # 機能通貨への換算か, 勘定科目の通貨への換算か、どっち?
        t.decimal :exchange_rate, precision: 14, scale: 4, null:false, default: 1.0
        t.decimal :account_balance, precision: 14, scale: 2, null:false, default: 0.0

        t.string  :description, null:false

        t.integer  :creator_id # related with created_at
        t.integer  :approver_id
        t.datetime :approver_datetime # conciliation
        t.integer  :nuller_id
        t.datetime :nuller_datetime # null
        t.boolean  :active, null:false, default: true
        t.boolean  :inverse, null:false, default: false

        t.boolean :has_error, default: false
        t.string  :error_messages

        # 文字列は効率が悪い.
        t.string  :status, limit: 50, null:false, default: 'approved'

        # nullable
        t.references :project, foreign_key: true

        t.timestamps
      end

      #add_index :account_ledgers, :currency
      #add_index :account_ledgers, :account_id
      #add_index :account_ledgers, :account_to_id
      #add_index :account_ledgers, :date
      #add_index :account_ledgers, :conciliation
      #add_index :account_ledgers, :operation
      #add_index :account_ledgers, :reference
      #add_index :account_ledgers, :active
      #add_index :account_ledgers, :has_error
      #add_index :account_ledgers, :project_id
      #add_index :account_ledgers, :status
    end
  end
end
