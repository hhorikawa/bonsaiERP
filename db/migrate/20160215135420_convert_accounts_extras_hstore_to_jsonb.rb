class ConvertAccountsExtrasHstoreToJsonb < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: "common" do
      execute("ALTER TABLE accounts ALTER COLUMN extras TYPE JSONB USING CAST(extras as JSONB);")
      add_index :accounts, :extras #, using: "gin"
    end
  end
end
