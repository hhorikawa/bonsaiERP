class AddPgTrgmExtension < ActiveRecord::Migration[5.2]
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA public'
  end

  def down
    execute 'DROP EXTENSION pg_trgm'
  end
end
