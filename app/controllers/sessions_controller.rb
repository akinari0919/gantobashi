class SessionsController < ApplicationController

  def index
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(hoge_url, notice: 'ログインしました')
    else
      flash[:alert] = 'ログイン失敗'
      render :new
    end
  end

  def destory
    logout
    redirect_to(root_url, notice: 'ログアウトしました')
  end
end
