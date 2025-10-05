class CreateLoans < ActiveRecord::Migration[8.0]
  def change
    # 借入金. 長期借入れは, 借入れごとに勘定科目を作る
    create_table :loans do |t|
      t.string :bank_name, null:false, comment:"銀行名+支店名"

      # 最新の利率
      t.decimal :interest_rate, precision:7, scale:4, null:false, comment: "percent"
      
      # nullable
      t.date   :due_date
      
      t.timestamps
    end
  end
end
