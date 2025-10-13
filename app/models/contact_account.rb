
# author: Boris Barroso
# email: boriscyber@gmail.com

# 取引先の口座. 口座なしも一つづつ作る. 自然に人名勘定になる。
class ContactAccount < ApplicationRecord  # Account から派生
  # 仮想的な親: 勘定科目
  include Accountable
  
  # 親
  belongs_to :contact

  before_validation :check
  
  validates_uniqueness_of :account_no, scope: :contact_id, allow_nil:true


private

  # for before_validation
  def check
    self.account_no = nil if account_no.blank?
  end
  
end
