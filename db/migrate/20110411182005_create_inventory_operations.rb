class CreateInventoryOperations < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do

      # 入出庫伝票。
      create_table :inventories, id: :serial do |t|
        t.date   :date, null:false
        t.string :ref_number
        t.string :operation, limit: 10, null:false

        t.string "state", limit: 50, null: false

        # sales, purchase, transfer, production order. nullable
        t.references :order, type: :integer, foreign_key:true

        # 店は必須
        t.references :store, type: :integer, null:false, foreign_key:true

        # sales order なしの出庫 = 売上科目
        t.references :account, type: :integer, foreign_key:true

        t.string :description, null:false

        t.decimal :total, :precision => 14, :scale => 2, default: 0

        t.integer  :creator_id, null:false
        t.integer  :transference_id
        t.integer  :store_to_id
        
        #t.references :project, type: :integer, foreign_key:true

        t.boolean :has_error, null:false, default: false
        t.jsonb   :error_messages

        t.timestamps
      end

      #add_index :inventory_operations, :contact_id
      #add_index :inventory_operations, :store_id
      #add_index :inventory_operations, :account_id
      #add_index :inventory_operations, :project_id

      #add_index :inventory_operations, :date
      #add_index :inventory_operations, :ref_number
      #add_index :inventory_operations, :operation
      #add_index :inventory_operations, :state
      #add_index :inventory_operations, :has_error
    end
  end
end
