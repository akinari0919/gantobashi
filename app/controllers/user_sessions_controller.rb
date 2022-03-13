class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to profile_path, notice: 'success'
    else
      flash.now[:alert] = 'failure'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'success'
  end
end
