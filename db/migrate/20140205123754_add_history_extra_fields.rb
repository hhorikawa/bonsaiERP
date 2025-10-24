class AddHistoryExtraFields < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      change_table :histories do |t|
        t.jsonb :extras
        t.jsonb :all_data, null:false, default:{}
      end
    end
  end

  def down
    PgTools.with_schemas except: 'common' do
      change_table :histories do |t|
        t.remove :extras
        t.remove :all_data
      end
    end
  end
end
