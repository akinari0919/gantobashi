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
    @user = User.find(params[:id])
    @gfp = @user.glaring_face_photos.find_by(main_choiced: true)
    unless params.present?
      @my_photo = params[:image]
      @enemy_image = params[:enemy_image]
      if params[:enemy_score].to_i > params[:face_score].to_i
        count = @gfp.defense_win_count
        @gfp.update(defense_win_count: count + 1)
        render json: { body: "Lose",
                       count: @gfp.defense_win_count
                     }
      else
        render json: { body: "Win" }
      end
    end
  end

  def update
    redirect_to "/mode/battle/result/#{params[:id]}"
  end

  def result
    @enemy_image = params[:enemy_image]
    @my_photo = params[:image]
    @gfp = GlaringFacePhoto.find(params[:enemy_id])
    if params[:enemy_score].to_i > params[:face_score].to_i
      count = @gfp.defense_win_count
      @gfp.update(defense_win_count: count + 1)
      render json: { body: "Lose",
                     count: @gfp.defense_win_count
                   }
    else
      render json: { body: "Win" }
    end
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
end
