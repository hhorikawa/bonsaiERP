class CreateInventoryOperationDetails < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      # 後続で `inventory_details` に名称変更
      create_table :inventory_operation_details do |t|
        # 親
        t.references :inventory_operation, null:false, foreign_key:true

        t.column :movement_type, "SMALLINT NOT NULL"
        
        t.references :item, null:false, foreign_key:true
        t.decimal :price, precision: 14, scale: 2, null:false, default: 0.0

        t.references :store, null:false, foreign_key:true

        t.decimal :quantity, :precision => 14, :scale => 2, null:false, default: 0.0

        t.timestamps
      end

      #add_index :inventory_operation_details, :inventory_operation_id
      #add_index :inventory_operation_details, :item_id
      #add_index :inventory_operation_details, :store_id
    end
  end
end
