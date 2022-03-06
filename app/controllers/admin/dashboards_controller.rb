class Admin::DashboardsController < Admin::BaseController
  def index
    @users_count = User.all.count
    @public_images_count = GlaringFacePhoto.where(main_choiced: true).count
  end
end
