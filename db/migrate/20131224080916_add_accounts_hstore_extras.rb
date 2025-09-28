class AddAccountsHstoreExtras < ActiveRecord::Migration[5.2]
  def up
    PgTools.change_schema 'public'
    PgTools.all_schemas.each do |schema|
      next  if schema == 'common'
      execute "ALTER TABLE #{schema}.accounts ADD COLUMN extras TEXT"
    end
  end

  def down
    PgTools.all_schemas.each do |schema|
      next  if schema == 'common'
      PgTools.change_schema schema
      execute "ALTER TABLE accounts DROP COLUMN IF EXISTS extras"
    end
  end
end
