class SetOrganisationSettingsJsonb < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas only: 'common' do
      #change_column :organisations, :settings, :text, :default => nil
    end
  end

  def down
    PgTools.with_schemas only: 'common' do
      change_column :organisations, :settings, :hstore, :default => {"inventory"=>"true"}
    end
  end
end
