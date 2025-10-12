class CreateHistories < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas except: 'common' do
      # 各マスタの履歴
      create_table :histories do |t|
        t.references :user, null:false, foreign_key:true, comment:"created by"

        # *_type, *_id の 2カラム
        t.references :historiable, null:false, polymorphic: true
        
        t.boolean :new_item, null:false, default: false
        #t.string :historiable_type
        t.jsonb :history_data

        t.datetime :created_at, null:false
      end
      #add_index :histories, :user_id
      #add_index :histories, [:historiable_id, :historiable_type]
      #add_index :histories, :created_at
    end
  end

  def down
    PgTools.with_schemas except: 'common' do
      remove_index :histories, :user_id
      remove_index :histories, [:historiable_id, :historiable_type]
      remove_index :histories, :created_at

      drop_table :histories
    end
  end
end
