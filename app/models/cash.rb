
# author: Boris Barroso
# email: boriscyber@gmail.com

# 自社の銀行口座・現金マスタ
class Cash < ApplicationRecord # Account から派生
  # 仮想的な親: 勘定科目
  include Accountable

=begin
  # can't use Bank.stored_attributes methods[:extras]
  alias_method :old_attributes, :attributes
  def attributes
    old_attributes.merge(
      Hash[EXTRA_COLUMNS.map { |k| [k.to_s, send(k)] }]
    )
  end
=end
  
  # Related methods for money accounts
  include Models::Money

  def to_s
    account.name
  end

  def pendent_ledgers_tag
    # 内容不明
  end

  
private
  
    def set_defaults
      self.total_amount ||= 0.0
    end
end
