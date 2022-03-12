class Admin::BattleHistoriesController < Admin::BaseController
  def index
    @battle_histories = BattleHistory.all.order(created_at: :desc)
  end
end
