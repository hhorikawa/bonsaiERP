
# 品目クラスの勘定科目
class ItemAccounting < ApplicationRecord
  has_many :items

  belongs_to :stock_ac, class_name:"Account"
  belongs_to :revenue_ac, class_name:"Account"
  belongs_to :purchase_ac, class_name:"Account"
  belongs_to :ending_inv_ac, class_name:"Account"
  
  validates_presence_of :name
  validates_uniqueness_of :name

  # 品目タイプについては, 例えば
  #   https://note.com/biznology/n/nbc2c463ca9fc
  #   「Technology」初めてのSAP-(3)SAPマスタの考え方
  ITEM_TYPES = {
    'HAWA' => 'Trading Goods',
    'FERT' => 'Finished Product',
    'HALB' => 'Semifinished Product', # 半製品 (これは仕掛品とは異なる)
    'ROH' => 'Raw Materials',
  }
  
  validates_inclusion_of :item_type, in: ITEM_TYPES.keys

end
