class ItemTransReport < Struct.new(:id, :name, :tot)
  def total
    tot.to_f
  end
end