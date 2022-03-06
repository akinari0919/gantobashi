class Admin::DashboardsController < Admin::BaseController
  def index
    @users_count = User.all.count
  end
end
