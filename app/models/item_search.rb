
class ItemSearch < BaseForm
  # 2値のときは :boolean
  attribute :active, :integer,    default: 0
  attribute :for_sale, :integer,  default: 0
  attribute :stockable, :integer, default: 0
  attribute :search, :string, default: ""

=begin
  # 単純に params.require(:hoge) を与えると, ActiveModel::ForbiddenAttributesError
  def initialize attributes = nil
    super(attributes)
  end
=end

  def nothing?
    return self.active == 0 && self.for_sale == 0 && self.stockable == 0 &&
           self.search.blank?
  end
end

