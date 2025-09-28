class ConvertOrgSettingsToJson < ActiveRecord::Migration[5.2]
  def up
    #execute("ALTER TABLE common.organisations ALTER COLUMN settings TYPE JSONB USING CAST(settings as JSONB);")
  end

  def down
  end
end
