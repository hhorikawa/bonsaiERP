class ChangeAccountsDescription < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      change_column :accounts, :description, :text
      add_index :accounts, :description
    end
  end

  def down
    PgTools.with_schemas except: 'common' do
      change_column :accounts, :description, :string, limit: 500
      remove_index :accounts, :description
    end
  end
end
