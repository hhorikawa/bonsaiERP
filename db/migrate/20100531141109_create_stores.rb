class CreateStores < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      create_table :stores, id: :serial do |t|
        t.string :name, null:false
        t.string :address, null:false
        t.string :phone
        t.boolean :active, null:false, default: true
        t.string :description, null:false

        t.timestamps
      end
    end
  end
end
