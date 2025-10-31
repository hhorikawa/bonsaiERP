
class ItemSearch < BaseForm
  # 2値のときは :boolean
  attribute :active, :integer,    default: 0
  attribute :for_sale, :integer,  default: 0
  attribute :stockable, :integer, default: 0
  attribute :search, :string, default: ""


  def nothing?
    return active == 0 && for_sale == 0 && stockable == 0 && search.blank?
  end
  
  def search_by_text
    ret = Item
    ret = ret.where(active: active == 1) if active != 0
    ret = ret.where(for_sale: for_sale == 1) if for_sale != 0
    ret = ret.where(stockable: stockable == 1) if stockable != 0
    ret = ret.search(search) if !search.blank?
    #@items = @items.any_tags(*tag_ids)  if tag_ids
    return ret
  end
end

