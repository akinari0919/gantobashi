class CreateBattleHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :battle_histories, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :glaring_face_photo, null: false, foreign_key: true, type: :uuid
      t.integer :challenger_score, null:  false
      t.integer :result, null: false

      t.timestamps
    end
  end
end
