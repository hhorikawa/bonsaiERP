class CreateItems < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      create_table :items, id: :serial do |t|
        # UoM
        t.references :unit, type: :integer, null:false, foreign_key:true

        t.references :account, type: :integer, null:false, foreign_key:true
        
        t.decimal :price, precision: 14, scale: 2, null:false, default: 0.0
        t.string  :name, null:false
        t.string  :description, null:false
        t.string  :code, limit: 100, null:false, index: {unique: true}
        t.boolean :for_sale, null:false, default: true
        t.boolean :stockable, null:false, default: true
        t.boolean :active, null:false, default: true

        t.timestamps
      end

      #add_index :items, :unit_id
      #add_index :items, :code
      #add_index :items, :for_sale
      #add_index :items, :stockable
    end
  end
end
