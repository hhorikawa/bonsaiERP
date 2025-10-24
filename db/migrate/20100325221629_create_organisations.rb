class CreateOrganisations < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas only: ['common', 'public'] do
      create_table :organisations, id: :serial do |t|
        #t.integer :country_id
        t.string  :name, limit: 100, null:false
        t.string  :address
        t.string  :address_alt
        t.string  :phone     , limit: 20
        t.string  :phone_alt , limit: 20
        t.string  :mobile    , limit: 20
        # 請求書に表示したりする email.
        t.string  :email
        t.string  :website
        #t.integer :user_id

        # Service Plan
        t.date    :due_date

        # JSON
        t.text    :preferences

        # `time_zone_select()` で設定できる。
        # が, ユーザに属するのでは?
        t.string  :time_zone, limit: 100

        t.string :tenant, limit: 50, null:false
        t.column :currency, "CHAR(3) NOT NULL"

        t.timestamps
      end

      #add_index :organisations, :country_id
      #add_index :organisations, :due_date
      add_index :organisations, :tenant, unique: true
      #add_index :organisations, :currency
    end
  end
end
