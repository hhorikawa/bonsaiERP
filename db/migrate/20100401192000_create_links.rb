class CreateLinks < ActiveRecord::Migration[5.2]
  def up
    PgTools.with_schemas only: ['common', 'public'] do
      create_table :links do |t|
        # `references()` でも, 陽に null:false が必要
        t.references :organisation, type: :integer, null:false, foreign_key: true
        t.references :user, type: :integer, null:false, foreign_key: true
        t.string  :settings
        t.boolean :creator        , null:false, default: false
        t.boolean :master_account , null:false, default: false

        # 後続で名前を `role` に変更
        t.string   :rol           , limit: 50, null:false
        t.boolean  :active        , null:false, default: true

        t.timestamps
      end

      #add_index :links, :organisation_id
      #add_index :links, :user_id
    end
  end
end
