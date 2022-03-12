class GlaringFacePhoto < ApplicationRecord
  belongs_to :user
  has_many :beats, dependent: :destroy
  has_many :battle_histories

  def beated_by?(user)
    beats.where(user_id: user).exists?
  end
end
