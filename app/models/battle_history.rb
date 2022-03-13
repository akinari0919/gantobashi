class BattleHistory < ApplicationRecord
  belongs_to :user
  belongs_to :glaring_face_photo

  enum result: { challenger: 0, enemy: 1, draw: 2 }
end
