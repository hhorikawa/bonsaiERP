
# 個々の Product/Item ではなく, item-accounting class に対して勘定科目を設定
class CreateItemAccountings < ActiveRecord::Migration[8.0]
  def change
    create_table :item_accountings, id: :serial do |t|
      #t.string :code, null:false, index:{unique:true}
      t.string :name, null:false

      # 商品, 製品, 半製品, 材料
      t.string :item_type, limit:40, null:false

      # 三分法では上手くいかない?

      # 在庫
      t.references :stock_ac, type: :integer, null:false,
                   foreign_key:{to_table: :accounts}

      # 収益
      t.references :revenue_ac, type: :integer, null:false,
                   foreign_key:{to_table: :accounts}

      # 仕入れ
      t.references :purchase_ac, type: :integer, null:false,
                   foreign_key:{to_table: :accounts}

      # 期末商品棚卸高
      t.references :ending_inv_ac, type: :integer, null:false,
                   foreign_key:{to_table: :accounts}
      
      t.timestamps
    end

    change_table :items do |t|
      t.references :accounting, type: :integer, null:false,
                   foreign_key:{to_table: :item_accountings}
    end
  end
  
end
