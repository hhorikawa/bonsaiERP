class CreateProjects < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do

      create_table :projects, id: :serial do |t|
        t.string :name, null:false
        t.boolean :active, null:false, default: true
        t.date :date_start
        t.date :date_end

        t.text :description, null:false

        t.timestamps
      end

      #add_index :projects, :active
    end
  end
end
