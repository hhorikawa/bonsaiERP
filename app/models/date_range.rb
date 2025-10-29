
# Creates date ranges for search
class DateRange < BaseForm 
  attribute :date_start, :date
  attribute :date_end, :date
  
  # nullable
  attribute :item_id, :integer

  # nullable
  attribute :store_id, :integer
  
  # 'year', 'month', 'week', 'day'
  attribute :time_strata, :string

  validates_presence_of :date_start
  validates_presence_of :date_end
  validates_presence_of :time_strata
  
  validate :check

  
  def range
    date_start..date_end
  end


  def self.last(days = 30)
    d = Time.zone.now.to_date
    new(d - days.days, d)
  end

  def self.range(s, e)
    s, e = (s.is_a?(String) ? Date.parse(s) : s), (e.is_a?(String) ? Date.parse(e) : e)
    new(s, e)
  end

  def self.parse(s, e)
    dr = new(Date.parse(s), Date.parse(e))
    fail 'Error'  unless dr.valid?

    dr
  rescue
    default
  end

  
private

  # for `validate()`
  def check
    if !(date_start <= date_end)
      errors.add :date_end, "must date_start <= date_end"
    end
  end
end

