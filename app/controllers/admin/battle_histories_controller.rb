class Admin::BattleHistoriesController < Admin::BaseController
  def index
    @battle_histories = BattleHistory.includes(:user, :glaring_face_photo).order(created_at: :desc)
  end
end
