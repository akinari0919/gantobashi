class Mode::BattleController < ApplicationController
  before_action :login_user
  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def login_user
    unless logged_in?
      redirect_to login_path
    end
  end
end
