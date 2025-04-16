class ContactReport < Struct.new(:contact, :tot)
  def to_s
    contact
  end
  
  def total
    tot.to_f
  end
end