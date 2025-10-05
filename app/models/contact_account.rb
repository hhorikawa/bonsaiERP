
# author: Boris Barroso
# email: boriscyber@gmail.com

# 取引先の口座. 口座なしも一つづつ作る. 自然に人名勘定になる。
class ContactAccount < ApplicationRecord  # Account から派生
  # 仮想的な親: 勘定科目
  include Accountable
  
  # 親
  belongs_to :contact
  
end
