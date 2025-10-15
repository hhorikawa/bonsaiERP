
# author: Boris Barroso
# email: boriscyber@gmail.com

# 取引先. 人名勘定
class PartnersController < ApplicationController
  include Controllers::TagSearch
  
  before_action :set_partner,
                only: [:show, :edit, :update, :destroy, :incomes, :expenses]

  # GET /contacts
  def index
    @search_term = !params[:search].blank? ? params[:search] : nil
    
    if @search_term
      @partners = Contact.search(@search_term)
    else
      @partners = Contact.order('matchcode asc')
    end
    @partners = @partners.page(@page)
    
    #@contacts = @contacts.any_tags(*tag_ids)  if tag_ids
  end

  
  # GET /contacts/1
  def show
    params[:operation] ||= 'all'
  end

  # GET /contacts/new
  def new
    # 最初から口座を一つ作る
    @partner = Contact.new
    @contact_account = ContactAccount.new account: Account.new(currency:"JPY", active:true)
  end

  # GET /contacts/1/edit
  def edit
  end
  
  # POST /contacts
  def create
    @partner = Contact.new(contact_params)
    if @partner.save
      redirect_to({action:"show", id: @partner}, notice: 'Se ha creado el contacto.')
    else
      render :new, status: :unprocessable_entity 
    end
  end

  # PUT /contacts/1
  def update
    @partner.assign_attributes(contact_params)
    if @partner.save
      redirect_to @partner
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  
  # DELETE /contacts/1
  def destroy
    @partner.destroy!

    if @contact.destroyed?
      flash[:notice] = 'El contacto fue eliminado'
    else
      flash[:error] = 'No fue posible eliminar el contacto'
    end

    redirect_to contacts_path, status: :see_other
  end


  # GET /contacts/:id/expenses
  def expenses
    params[:page_expenses] ||= 1
  end

  # GET /contacts/:id/incomes
  def incomes
    params[:page_incomes] ||= 1
  end
  
  
private

  def set_partner
    @partner = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:matchcode, :name, :email, :phone, :mobile, :tax_number, :address)
  end


    def export_contacts
      send_data StringEncoder.encode("UTF-8", "ISO-8859-1", generate_csv("\t") ), filename: "contactos-p#{@page}.xls"
    end

    def generate_csv(col_sep = ',')
      require 'csv'

      CSV.generate(col_sep: col_sep) do |csv|
        csv << csv_header
        @contacts.per(200).find_each do |cont|
          csv << [cont.matchcode, cont.email, cont.phone, cont.mobile, cont.address]
        end
      end
    end

    def csv_header
      %w(Name Email Phone Mobile Address)
    end
end
