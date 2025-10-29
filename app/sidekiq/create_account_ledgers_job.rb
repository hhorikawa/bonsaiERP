
# daily job
class CreateAccountLedgersJob
  include Sidekiq::Job

=begin
  def goods_receipt_po 
    amt = {}
    InventoryDetail.eager_load(:inventory).where(...).each do |detail|
      # 三分法でやってみる
      amt[detail.item.accounting.purchase_ac_id,
          detail.inventory.account_id] =
                    (amt[detail.item.accounting.purchase_ac_id, detail.inventory.account_id] || 0) +
                    detail.price * detail.quantity
    end

    ActiveRecord::Base.transaction do
      entry_no = rand(2_000_000_000)
      # Dr.
      sum_amt = 0
      amt.each do |key_ary, a|
        r = AccountLedger.new date: @inv.date, entry_no: entry_no,
                            operation: 'trans',
                            account_id: key_ary[0],  # Dr.
                            amount: a,  # 取引通貨
                            currency: @inv.order.currency,
                            description: "goods receipt po",
                            creator_id: current_user.id,
                            status: 'approved',
                            inventory_id: @inv.id
          r.save!
          sum_amt += a
        end
        # Cr.
        r = AccountLedger.new date: @inv.date, entry_no: entry_no,
                            operation: 'trans',
                            account_id: @inv.account_id,
                            amount: -sum_amt,  # 取引通貨, 貸方マイナス
                            currency: @inv.order.currency,
                            description: "goods receipt po",
                            creator_id: current_user.id,
                            status: 'approved',
                            inventory_id: @inv.id
        r.save!
      end # transaction
    rescue ActiveRecord::RecordInvalid => e
      raise e.inspect
      return
    end
      
    redirect_to({action:"show", id: @inv})
  end
=end

  
  def perform(*args)
    # Do something

    # 債権債務が絡む取引は、都度つど仕訳を作る
    #goods_receipt_po()
  end
end
