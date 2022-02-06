class Mode::BattleController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end
end
