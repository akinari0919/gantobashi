class RenameBattleWinCountColumnToGlaringFacePhotos < ActiveRecord::Migration[6.1]
  def change
    rename_column :glaring_face_photos, :battle_win_count, :defense_win_count
  end
end
