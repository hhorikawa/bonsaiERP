
# author: Boris Barroso
# email: boriscyber@gmail.com

# form object (search)
class AccountLedgers::Query < BaseForm
  attribute :text, :string

  attribute :from, :date
  attribute :to, :date

  attribute :account_id, :integer

  attribute :state, array: true, default: ['approved']
  
  #def initialize(rel = AccountLedger)
  #  @rel = rel
  #end

  def money(id)
    @rel.where(t[:account_id].eq(id).or(t[:account_to_id].eq(id)))
    .order('account_ledgers.date desc, account_ledgers.id desc')
    .includes(:contact, :account_to, :approver, :creator, :nuller, :updater)
  end

  def money_paged(id, page)
    money.page(page)
  end

  def payments(account_id)
    @rel.select(payment_columns(account_id).join(', '))
    .where('account_id=:id OR account_to_id=:id', id: account_id)
    .includes(:account, :account_to, :approver, :creator, :nuller, :updater)
  end

  def payments_ordered(account_id)
    payments(account_id).order('date desc, id desc')
  end

  
  def search()
    # TODO: date なども調べる
    AccountLedger.eager_load(:account)
            .where("reference ILIKE :s OR description ILIKE :s ", s: text)
  end

  
private

    def payment_columns(account_id)
      AccountLedger.column_names + ["account_id=#{account_id} AS is_account"]
    end

    #def t
    #  AccountLedger.arel_table
    #end
end
