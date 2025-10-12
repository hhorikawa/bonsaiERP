class CreateContacts < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      # Business Partners
      create_table :contacts do |t|
        t.string :matchcode, limit:100, null:false, index:{unique:true}
        #t.string :first_name, limit: 100
        t.string :name, null:false
        
        #t.string :organisation_name, limit: 100
        t.string :address, limit: 250, comment:"headquarters"
        t.string :phone, limit: 20
        t.string :mobile, limit: 20
        t.string :email, limit: 200
        t.string :tax_number, limit: 30, index:{unique:true}
        t.string :aditional_info, limit: 250

        #t.string  :code
        #t.string  :type
        t.string  :position
        t.boolean :active, null:false, default: true

        # Important to recognize Staff
        t.boolean :staff,  null:false, default: false
        t.boolean :client, null:false, default: false
        t.boolean :supplier, null:false, default: false

        # Money Owned, Incomes, Expense, etc, all realted accounts
        t.string :money_status

        t.timestamps
      end

      #add_index :contacts, :matchcode
      #add_index :contacts, :first_name
      #add_index :contacts, :last_name
      #add_index :contacts, :client
      #add_index :contacts, :supplier
      #add_index :contacts, :active
      #add_index :contacts, :staff
    end
  end
end
