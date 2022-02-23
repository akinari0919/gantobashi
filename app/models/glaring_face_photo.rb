class GlaringFacePhoto < ApplicationRecord
  belongs_to :user
  has_many :beats, dependent: :destroy

  def beated_by?(user)
    beats.where(user_id: user).exists?
  end
end
