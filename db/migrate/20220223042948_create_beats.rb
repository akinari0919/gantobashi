class CreateBeats < ActiveRecord::Migration[6.1]
  def change
    create_table :beats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :glaring_face_photo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
