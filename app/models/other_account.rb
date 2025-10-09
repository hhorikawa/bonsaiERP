

# その他の勘定科目
class OtherAccount < ApplicationRecord
  # 仮想的な親: 勘定科目
  include Accountable
end
