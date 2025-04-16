class DailyReport < Struct.new(:tot, :date)
  def total
    tot.to_f
  end
end