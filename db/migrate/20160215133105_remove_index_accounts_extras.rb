class RemoveIndexAccountsExtras < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: "common" do
      remove_index :accounts, :extras
    end
  end

  def down
  end
end
