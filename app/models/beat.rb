class Beat < ApplicationRecord
  belongs_to :user
  belongs_to :glaring_face_photo

  validates :user_id, uniqueness: { scope: :glaring_face_photo_id }
end
