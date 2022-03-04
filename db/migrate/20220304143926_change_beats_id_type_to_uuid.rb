class ChangeBeatsIdTypeToUuid < ActiveRecord::Migration[6.1]
  def up
    # event_partivipantsテーブルにuuid追加
    add_column :beats, :uuid, :uuid, null: false, default: 'gen_random_uuid()'

    # beatsのidを消して、追加したuuidのカラム名をidに変更
    change_table :beats do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    # beatsのuuid化したidをprimary keyとして設定
    execute 'ALTER TABLE beats ADD PRIMARY KEY (id);'

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
