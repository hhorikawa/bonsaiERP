
# author: Boris Barroso
# email: boriscyber@gmail.com

# Form object for SalesOrder/PurchaseOrder
class Movements::Form < BaseForm
  # SalesOrder or PurchaseOrder
  attr_reader :model_obj

  # Array of MovementDetail
  attr_reader :details
  
  # form fields
  delegate :date, :contact_id, :currency, :delivery_date, :draft?, #:description, :tax_id,
           to: :model_obj

  # PO only
  delegate :ship_to_id, to: :model_obj, allow_nil:true
  
  # for field required star
  validates_presence_of :date
  validates_presence_of :delivery_date
  
  #validates_presence_of :currency
  validate :validate_models

  
  def initialize order
    raise TypeError if !(order.is_a?(SalesOrder) || order.is_a?(PurchaseOrder))
    @model_obj = order
    @details = order.details
  end

  
  # @param model_params   permitted params for model object
  # @param detail_params for nested array              
  def assign model_params, detail_params
    model_obj.assign_attributes model_params #.permit(.....)
    @details = Movements::Form.create_details_from_params(detail_params)
  end

  # ActiveModel::Validations  -> DON'T override `valid?` directly.
  #def valid?
  #     1. errors.clear
  #     2. run_validations!
  #     3. return errors.empty?
  #end

  
private

  # for `validate()`
  def validate_models
    # promote errors
    errors.merge!(model_obj.errors) if !model_obj.valid?

    # run validations for all nested objects
    err_count = details.count {|detail|
      # only useful when `:autosave` option is enabled.
      next if detail.respond_to?(:marked_for_destruction?) && detail.marked_for_destruction?
      !detail.valid?
    }
    if err_count > 0
      errors.add :details, "Some error(s)"
    end

    errors.add :details, "Item not unique" if !UniqueItem.new(self).valid?
  end

  
  # @param detail_params [Hash{lineno => Hash}] params
  #   {"1"=>{"item_id"=>"1", "price"=>"123", "quantity"=>"567", "description"=>"aaaa"},
  #    "2"=>{"item_id"=>"1", "price"=>"0.0", "quantity"=>"0.0", "description"=>""},
  def self.create_details_from_params(detail_params)
    #raise detail_params.inspect # DEBUG

    ary = []
    detail_params.each do |_lineno, h|
      m = MovementDetail.new h.permit(:item_id, :price, :quantity, :description)
      (ary << m) if m.quantity != 0.0
    end

    return ary
  end

end
