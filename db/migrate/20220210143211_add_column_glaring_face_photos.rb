class AddColumnGlaringFacePhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :glaring_face_photos, :main_choiced, :boolean, null: false, default: false
  end
end
