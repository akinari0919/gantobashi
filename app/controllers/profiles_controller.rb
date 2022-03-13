class ProfilesController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def show
    @glaring_face_photos = current_user.glaring_face_photos.where(main_choiced: true)
    @battle_histories = BattleHistory.where(user_id: current_user.id).order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
