
# 自社の銀行口座・現金
class CreateBankAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :cashes do |t|
      # nullable. 現金のときは NULL.
      t.string :bank_name, comment: "銀行名+支店名"
      t.string :bank_addr
      t.string :account_no, index: {unique:true}
      t.string :account_name

      # name は `accounts` table にある
      # 通貨は `accounts` table にある
      
      t.timestamps
    end
  end
end
