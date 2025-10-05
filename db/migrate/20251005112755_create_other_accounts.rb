
# その他の勘定科目
class CreateOtherAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :other_accounts do |t|
      t.boolean :inventory, null:false
      t.string :subtype, null:false
      
      t.timestamps
    end
  end
end
