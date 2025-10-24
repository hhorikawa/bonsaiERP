
# 取引先の口座. 口座なし (現金払い) が一つだけありうる
class CreateContactAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_accounts do |t|
      # 親
      t.references :contact, type: :integer, null:false, foreign_key:true

      # nullable. 現金払いのときは NULL.
      t.string :bank_name, comment: "銀行名+支店名"
      t.string :bank_addr
      t.string :account_no
      t.string :account_name
      
      t.timestamps
    end
    add_index :contact_accounts, [:contact_id, :account_no], unique:true
  end
end
