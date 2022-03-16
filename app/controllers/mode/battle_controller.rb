class Mode::BattleController < ApplicationController
  before_action :set_user, only: [:edit, :show]

  def index
    users = User.includes(:glaring_face_photos).where.not(id: current_user.id)
    users = users.joins(:glaring_face_photos).merge(GlaringFacePhoto.where(main_choiced: true))
    @users = users.order(created_at: :desc).page(params[:page])
  end

  def show
    gfp_id = GlaringFacePhoto.find_by(user_id: @user.id, main_choiced: true)
    battle_histories = BattleHistory.includes(:user, :glaring_face_photo)
    defense_battles = battle_histories.where(glaring_face_photo_id: gfp_id, result: 1)
    @defense_battles = defense_battles.order(created_at: :desc).limit(5)
  end

  def edit
    if @gfp.beated_by?(current_user)
      redirect_to mode_battle_path(params[:id])
    end
  end

  def result
    user = User.find(params[:enemy_id])
    gfp = user.glaring_face_photos.find_by(main_choiced: true)

    battle_history = BattleHistory.new(user_id: current_user.id,
                                       challenger_score: params[:my_score].to_i,
                                       glaring_face_photo_id: gfp.id
                                      )

    if params[:enemy_score].to_i > params[:my_score].to_i
      @my_win_result = current_user.offense_win_count
      count = gfp.defense_win_count
      gfp.update(defense_win_count: count + 1)
      @enemy_win_result = gfp.defense_win_count
      @battle_result = 'LOSE'
      # 勝敗履歴更新
      battle_history.update(result: 1)
    elsif params[:enemy_score].to_i < params[:my_score].to_i
      count = current_user.offense_win_count
      current_user.update(offense_win_count: count + 1)
      @my_win_result = current_user.offense_win_count
      @enemy_win_result = gfp.defense_win_count
      @battle_result = 'WIN'
      # 勝敗履歴更新
      battle_history.update(result: 0)
      # 再戦不可にする
      gfp.beats.create(user_id: current_user.id)
    else
      @my_win_result = current_user.offense_win_count
      @enemy_win_result = gfp.defense_win_count
      @battle_result = 'DRAW'
      # 勝敗履歴更新
      battle_history.update(result: 2)
    end

    render json: { battle_result: @battle_result,
                   my_win_count: "★×#{@my_win_result}",
                   enemy_win_count: "★×#{@enemy_win_result}",
                 }
  end

  private

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
