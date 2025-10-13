
# 取引先の口座. これが勘定科目
class ContactAccountsController < ApplicationController
  before_action :set_partner
  before_action :set_contact_account, only: %i[ show edit update destroy ]

  
  # GET /contact_accounts/1 or /contact_accounts/1.json
  def show
  end

  # GET /contact_accounts/new
  def new
    @contact_account = ContactAccount.new account: Account.new(currency:"JPY", active:true)
  end

  # GET /contact_accounts/1/edit
  def edit
  end

  # POST /contact_accounts or /contact_accounts.json
  def create
    @contact_account =
      ContactAccount.new account: Account.new(params.require(:contact_account)
                            .require(:account)
                            .permit(:name, :currency, :active, :description))
    @contact_account.assign_attributes contact_account_params
    @contact_account.contact_id = @partner.id
    begin
      ActiveRecord::Base.transaction do
        # save! だけだと account が作られない
        @contact_account.save!
        @contact_account.account.accountable = @contact_account
        @contact_account.account.subtype = 'APAR'
        @contact_account.account.creator_id = current_user.id
        @contact_account.account.save!
      end
    rescue ActiveRecord::RecordInvalid => e
      raise e.inspect
      render :new, status: :unprocessable_entity
      return
    end
    
    redirect_to({controller:"partners", action:"show", id:@partner.id},
                notice: "Contact account was successfully created." )
  end

  # PATCH/PUT /contact_accounts/1 or /contact_accounts/1.json
  def update
    respond_to do |format|
      if @contact_account.update(contact_account_params)
        format.html { redirect_to @contact_account, notice: "Contact account was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @contact_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_accounts/1 or /contact_accounts/1.json
  def destroy
    @contact_account.destroy!

    respond_to do |format|
      format.html { redirect_to contact_accounts_path, notice: "Contact account was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  
private

  def set_partner
    @partner = Contact.find(params[:partner_id])
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_contact_account
    @contact_account = ContactAccount.where(contact_id: @partner.id,
                                            id: params[:id]).take
    raise ActiveRecord::RecordNotFound if !@contact_account
  end

  # Only allow a list of trusted parameters through.
  def contact_account_params
    params.require(:contact_account).permit(:bank_name, :bank_addr, :account_no, :account_name)
  end
end
