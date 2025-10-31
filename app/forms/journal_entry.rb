
class JournalEntry < BaseForm
  attribute :date, :date
  attribute :entry_no, :integer
  
  attribute :lines, array: true

  def initialize ledgers
    raise TypeError if !ledgers
    super()
    
    self.lines = ledgers
    
    if !ledgers.empty?
      self.date = ledgers.first.date
      self.entry_no = ledgers.first.entry_no
    end
  end
end
