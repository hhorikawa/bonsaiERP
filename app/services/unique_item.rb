
# author: Boris Barroso
# email: boriscyber@gmail.com

# Checks for unique `item_id` and adds an error to the found details
class UniqueItem #< Struct.new(:klass)
  # 重複があるのは, 親レコードのほうのエラー
  attr_reader :model_obj
  
  def initialize model
    raise TypeError if !model.respond_to?(:details)
    @model_obj = model
  end

  
  def valid?
    res = true
    model_obj.details.each do |det|
      add_to_hash(det.item_id)

      if repeated_item?(det.item_id)
        res = false 
        det.errors.add(:item_id, I18n.t("errors.messages.item.repeated"))
      end
    end

    #if !res
    #  model_obj.errors.add(:base, I18n.t("errors.messages.item.repeated_items"))
    #end
    
    return res
  end

  
private
  
  def add_to_hash(item_id)
    @h ||= Hash.new(0)
    @h[item_id] += 1
  end

  def repeated_item?(item_id)
    @h[item_id] > 1
  end
end
