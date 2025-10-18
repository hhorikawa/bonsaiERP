
# author: Boris Barroso
# email: boriscyber@gmail.com

# フォームオブジェクトの基底クラス
class Inventories::Form < BaseForm
  # `Inventory` 入出庫伝票
  attr_reader :model_obj

  # Array of InventoryDetail
  attr_reader :details

  delegate :date, :store_id, :description, to: :model_obj
  # フォームに置くフィールドだけでよい
  delegate :ref_number, :project_id, to: :model_obj, allow_nil: true
  
  #delegate :stocks, :stock, :stocks_to, :detail, :item_ids, :item_quantity,
  #         to: :klass_details

  # field required red star
  validates_presence_of :date

  validate :validate_models

  def initialize model
    raise TypeError if !model.is_a?(Inventory)
    @model_obj = model
    @details = model.details
  end

  def assign model_params, detail_params
    model_obj.assign_attributes model_params
    @details = Inventories::Form.create_details_from_params(detail_params)
  end

  
private

  # for `validate()`
  def validate_models
    # promote errors
    errors.merge!(model_obj.errors) if !model_obj.valid?

    # run  validations for all nested objects
    err_count = details.count {|detail|
      # only useful when `:autosave` option is enabled.
      next if detail.respond_to?(:marked_for_destruction?) && detail.marked_for_destruction?
      !detail.valid?
    }
    if err_count > 0
      errors.add :details, "Some error(s)"
    end

    errors.add :details, "Item not unique" if !UniqueItem.new(self).valid?

    if details.empty?
      errors.add(:details, I18n.t("errors.messages.inventory.at_least_one_item"))
    end
  end

  #def store
  #  @store ||= Store.active.where(id: store_id).first
  #end

  def inventory
    @inventory ||= begin
      i = Inventory.new(
        store_id: store_id, date: date, description: description,
        inventory_details_attributes: get_inventory_details,
        operation: operation
      )
      i.set_ref_number
      i
    end
  end

  def details_serialized
    details.map do |v|
      v.attributes.merge(stock_with_items(v.item_id).attributes)
    end
  end

  
private

    def stock_with_items(item_id)
      stock_items_hash.fetch(item_id) { StockWithItem.new }
    end

    def stock_items_hash
      @stock_items_hash ||= begin
         res =  store.stocks.includes(:item).where(item_id: details.map(&:item_id))
         Hash[ res.map { |v| [v.item_id, StockWithItem.new(v)] }]
      end
    end

=begin
    # Saves and in case there are errors in inventory these are set on
    # the Iventories::Form instance
    def save(&b)
      res = valid? && @inventory.valid?
      res = commit_or_rollback { b.call } if res

      set_errors(@inventory) unless res

      res
    end
=end
  
    def get_inventory_details
      if inventory_details_attributes.nil?
        []
      else
        inventory_details_attributes
      end
    end

    def klass_details
      @klass_details ||= Inventories::Details.new(@inventory)
    end

    def self.public_attributes
      [:store_id, :date, :description]
    end


  #def unique_item_ids
  #self.errors.add(:base, I18n.t("errors.messages.item.repeated_items")) unless UniqueItem.new(@inventory).valid?
  #end

end


class StockWithItem
  attr_accessor :unit, :item, :stock

  def initialize(obj = nil)
    @item = obj.item_to_s
    @unit = obj.item_unit_symbol
    @stock = obj.quantity
  rescue
    @stock = BigDecimal.new(0)
  end

  def attributes
    { item: item, unit: unit, stock: stock }
  end
end
