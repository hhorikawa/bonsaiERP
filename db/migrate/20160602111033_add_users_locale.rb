class AddUsersLocale < ActiveRecord::Migration[5.2]
  def change
    PgTools.with_schemas only: ["common", "public"] do
      add_column :users, :locale, :string, default: "en"
    end
  end
end
