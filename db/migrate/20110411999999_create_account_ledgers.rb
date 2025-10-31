class CreateAccountLedgers < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do

      # 仕訳の1行
      create_table :account_ledgers do |t|
        t.date :date, null:false
        t.integer :entry_no, null:false
        
        t.string   :reference
        t.string   :operation, limit: 20, null:false

        # 例えば, 勘定科目は円で, 外貨債務の支払いがある。
        t.references :account, type: :integer, null:false, foreign_key:true
        
        # 仕訳は2行以上
        #t.integer  :account_to_id
        #t.decimal  :account_to_balance, precision: 14, scale: 2, default: 0.0

        #t.boolean :conciliation, null:false, default: true

        # 取引金額, 取引通貨
        t.decimal :amount, precision: 14, scale: 2, null:false, default: 0.0,
                           comment: "借方がプラス"
        t.column  :currency, "CHAR(3) NOT NULL", comment: "取引通貨"

        # 機能通貨への換算か, 勘定科目の通貨への換算か、どっち?
        t.decimal :exchange_rate, precision: 14, scale: 4, null:false, default: 1.0
        t.decimal :account_balance, precision: 14, scale: 2, null:false, default: 0.0

        t.string  :description, null:false

        t.integer  :creator_id, null:false  # related with created_at
        t.integer  :approver_id
        t.datetime :approver_datetime # conciliation
        t.integer  :nuller_id
        t.datetime :nuller_datetime # null
        #t.boolean  :active, null:false, default: true
        t.boolean  :inverse, null:false, default: false

        t.boolean :has_error, default: false
        t.string  :error_messages

        # TODO: 文字列は効率が悪い.
        t.string  :status, limit: 50, null:false, default: 'approved'

        # nullable
        #t.references :project, type: :integer, foreign_key: true

        # goods receipt PO, delivery. nullable
        t.references :inventory, type: :integer, foreign_key: true
        
        t.timestamps
      end
    end
  end
  
end
