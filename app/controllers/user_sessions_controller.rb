class UserSessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to mode_select_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
