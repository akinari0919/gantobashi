class Mode::BattleController < ApplicationController
  before_action :login_user
  before_action :set_user, only: [:edit, :show]

  def index
    users = User.where.not(id: current_user.id).joins(:glaring_face_photos).merge(GlaringFacePhoto.where(main_choiced: true))
    @users = users.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def edit
    if @gfp.beated_by?(current_user)
      redirect_to mode_battle_path(params[:id])
    end
  end

  def result
    user = User.find(params[:enemy_id])
    gfp = user.glaring_face_photos.find_by(main_choiced: true)
    if params[:enemy_score].to_i > params[:my_score].to_i
      @my_win_result = current_user.offense_win_count
      count = gfp.defense_win_count
      gfp.update(defense_win_count: count + 1)
      @enemy_win_result = gfp.defense_win_count
      @battle_result = 'LOSE'
    elsif params[:enemy_score].to_i < params[:my_score].to_i
      count = current_user.offense_win_count
      current_user.update(offense_win_count: count + 1)
      @my_win_result = current_user.offense_win_count
      @enemy_win_result = gfp.defense_win_count
      @battle_result = 'WIN'
      # 再戦不可にする
      gfp.beats.create(user_id: current_user.id)
    else
      @my_win_result = current_user.offense_win_count
      @enemy_win_result = gfp.defense_win_count
      @battle_result = 'DRAW'
    end

    render json: { battle_result: @battle_result,
                   my_win_count: "★×#{@my_win_result}",
                   enemy_win_count: "★×#{@enemy_win_result}",
                 }
  end

  private

  def login_user
    unless logged_in?
      redirect_to login_path
    end
  end

  def set_user
    if current_user.id.to_s == params[:id]
      redirect_back(fallback_location: mode_battle_index_path)
    end
    @user = User.find(params[:id])
    @gfp = @user.glaring_face_photos.find_by(main_choiced: true)
  end

  def find_glaring_face_photo
    @glaring_face_photo = GlaringFacePhoto.find(params[:id])
  end
end
