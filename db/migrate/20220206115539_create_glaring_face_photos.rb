class CreateGlaringFacePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :glaring_face_photos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :image, null: false
      t.integer :face_score, null: false
      t.integer :battle_win_count, null: false, default: 0

      t.timestamps
    end
  end
end
