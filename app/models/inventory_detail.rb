
# author: Boris Barroso
# email: boriscyber@gmail.com

# 個々の伝票にぶら下がる, アイテムの変動
#   購買入庫   quantity > 0, valuation = true
#   購買返品   quantity < 0, valuation = true  受入側のマイナス
#   出荷/納入  quantity < 0, valuation = false
#   顧客返品   quantity > 0, valuation = false
#   直送       N/A
#   在庫転送   出し側 quantity < 0, valuation = false
#              受け側 quantity > 0, valuation = false
class InventoryDetail < ApplicationRecord
  # 親
  belongs_to :inventory
  belongs_to :item

  validates_presence_of :item_id
  # 預託品の場合は, 預託品倉庫への転送扱い
  validates_presence_of :store_id

  ●追加 unit_price
  ●追加 valuation
  ●追加 project_id  nullable
  
  # 入庫 = 0 以上, 出庫 = マイナス
  validates_presence_of :quantity
  #validates_numericality_of :quantity, greater_than: 0

  attr_accessor :available
end
