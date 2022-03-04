class ChangeGlaringFacePhotosIdTypeToUuid < ActiveRecord::Migration[6.1]
  def up
    # glaring_face_photosテーブルにuuid追加
    add_column :glaring_face_photos, :uuid, :uuid, null: false, default: 'gen_random_uuid()'

    # 関連テーブルにuuid追加
    add_column :beats, :glaring_face_photo_uuid, :uuid

    # 関連テーブルのuuidを更新(これでglaring_face_photosのuuidとglaring_face_photosのglaring_face_photo_uuidが紐づく)
    execute <<~SQL
      UPDATE beats SET glaring_face_photo_uuid = glaring_face_photos.uuid
      FROM glaring_face_photos WHERE beats.glaring_face_photo_id = glaring_face_photos.id;
    SQL

    # glaring_face_photosの元々のprimary keyであるidを消す
    # 外部キーとして参照されていると消せないので、関連テーブルからの参照を切る
    remove_foreign_key :beats, :glaring_face_photos
    remove_reference :beats, :glaring_face_photo, index: true

    # glaring_face_photosのidを消して、追加したuuidのカラム名をidに変更
    change_table :glaring_face_photos do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    # glaring_face_photosのuuid化したidをprimary keyとして設定
    execute 'ALTER TABLE glaring_face_photos ADD PRIMARY KEY (id);'

    # 関連テーブルに追加したuuidを元々あった名前に変更(元々あったglaring_face_photo_idはglaring_face_photosテーブルのidを消した時に消えてるはずなので競合しない)
    rename_column :beats, :glaring_face_photo_uuid, :glaring_face_photo_id

    # 関連テーブルのuuid化したglaring_face_photo_idを外部キーとして設定
    add_foreign_key :beats, :glaring_face_photos
    add_index :beats, :glaring_face_photo_id
    change_column_null :beats, :glaring_face_photo_id, false
  end

  def down
    # idに戻すことは無いと思うのでroleback不可を明示的にする
    raise ActiveRecord::IrreversibleMigration
  end
end
