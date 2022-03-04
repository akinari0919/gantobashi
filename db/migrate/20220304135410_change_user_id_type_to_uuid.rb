class ChangeUserIdTypeToUuid < ActiveRecord::Migration[6.1]
  def up
    # usersテーブルにuuid追加
    add_column :users, :uuid, :uuid, null: false, default: 'gen_random_uuid()'

    # 関連テーブルにuuid追加
    add_column :glaring_face_photos, :user_uuid, :uuid
    add_column :beats, :user_uuid, :uuid

    # 関連テーブルのuuidを更新(これでusersのuuidとglaring_face_photosのuser_uuidが紐づく)
    execute <<~SQL
      UPDATE glaring_face_photos SET user_uuid = users.uuid
      FROM users WHERE glaring_face_photos.user_id = users.id;
    SQL
    execute <<~SQL
      UPDATE beats SET user_uuid = users.uuid
      FROM users WHERE beats.user_id = users.id;
    SQL

    # usersの元々のprimary keyであるidを消す
    # 外部キーとして参照されていると消せないので、関連テーブルからの参照を切る
    remove_foreign_key :glaring_face_photos, :users
    remove_foreign_key :beats, :users
    remove_reference :glaring_face_photos, :user, index: true
    remove_reference :beats, :user, index: true

    # usersのidを消して、追加したuuidのカラム名をidに変更
    change_table :users do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    # usersのuuid化したidをprimary keyとして設定
    execute 'ALTER TABLE users ADD PRIMARY KEY (id);'

    # 関連テーブルに追加したuuidを元々あった名前に変更(元々あったuser_idはusersテーブルのidを消した時に消えてるはずなので競合しない)
    rename_column :glaring_face_photos, :user_uuid, :user_id
    rename_column :beats, :user_uuid, :user_id

    # 関連テーブルのuuid化したuser_idを外部キーとして設定
    add_foreign_key :glaring_face_photos, :users
    add_foreign_key :beats, :users
    add_index :glaring_face_photos, :user_id
    add_index :beats, :user_id
    change_column_null :beats, :user_id, false
  end

  def down
    # idに戻すことは無いと思うのでroleback不可を明示的にする
    raise ActiveRecord::IrreversibleMigration
  end
end
