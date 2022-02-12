class Mode::BattleController < ApplicationController
  before_action :login_user
  before_action :set_user, only: :edit
  before_action :find_glaring_face_photo, only: :update
  include AwsRecognition

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @photo = @user.glaring_face_photos.find_by(main_choiced: true)
  end

  def edit
  end

  def update
    if @glaring_face_photo.face_score > glaring_face_photo_params[:face_score].to_i
      count = @glaring_face_photo.battle_win_count
      @glaring_face_photo.update(battle_win_count: count + 1)
    end
    redirect_to mode_battle_index_path
  end

  private

  def login_user
    unless logged_in?
      redirect_to login_path
    end
  end

  def set_user
    @user = User.find(params[:id])
    @glaring_face_photo = @user.glaring_face_photos.find_by(main_choiced: true)
  end

  def find_glaring_face_photo
    @glaring_face_photo = GlaringFacePhoto.find(params[:id])
  end

  def glaring_face_photo_params
    params.require(:glaring_face_photo).permit(:image, :face_score)
  end

end
