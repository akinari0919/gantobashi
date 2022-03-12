class BattleHistory < ApplicationRecord
  belongs_to :user
  belongs_to :glaring_face_photo
end
