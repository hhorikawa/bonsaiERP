
class CreateAccounts < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      # 勘定科目マスタ.
      # マスタっぽくないフィールドが大量にあるが, マスタのはず.
      create_table :accounts do |t|
        t.string  :name, null:false, index: {unique:true}

        # 通貨は勘定科目ごとに持つ。人名勘定なので可能.
        t.column  :currency, "CHAR(3) NOT NULL"
        
        t.boolean :active, null:false, default: true
        t.string  :description, limit: 500, null:false

        # delegated_type (= polymorphic) にする. nullable
        t.string :accountable_type, limit:80 #, null:false
        t.integer :accountable_id #, null:false

        # 売上, 変動費, 非変動費, ...
        t.string :subtype, null:false
        
        # この意味?
        t.decimal :exchange_rate, precision: 14, scale: 4, default: 1.0
        #t.decimal :amount, precision: 14, scale: 2, default: 0.0

        #t.integer :contact_id
        #t.integer :project_id
        
        # この意味?
        #t.date    :date
        #t.string  :state, limit: 30
        
        t.boolean :has_error, null:false, default: false
        t.jsonb   :error_messages #, limit: 400

        t.timestamps
      end

      #add_index :accounts, :name, unique: true
      #add_index :accounts, :amount
      #add_index :accounts, :currency
      #add_index :accounts, :type
      #add_index :accounts, :contact_id
      #add_index :accounts, :project_id
      #add_index :accounts, :active
      #add_index :accounts, :date
      #add_index :accounts, :state
      #add_index :accounts, :has_error
    end
  end
end
