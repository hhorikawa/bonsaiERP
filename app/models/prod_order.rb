
# author: Boris Barroso
# email: boriscyber@gmail.com

# このプロジェクトは、単に経費を括るだけのもの。タスク管理・進捗管理も何もない
# -> make new Production Order
class ProdOrder < Order

  # associations
  has_many :accounts
  has_many :account_ledgers

  # validations
  validates_presence_of :name
  validates_lengths_from_database

  scope :active, -> { where(active: true) }

  def to_s
    name
  end

  def to_param
    "#{id}-#{to_s}".parameterize
  end
end
