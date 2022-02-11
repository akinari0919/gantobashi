class GlaringFacePhotosController < ApplicationController
  before_action :login_user
  before_action :find_glaring_face_photo, only: [:update, :destroy]
  include AwsRecognition

  def new
    if current_user.glaring_face_photos.count >= 3
      redirect_to glaring_face_photos_path
    else
      @glaring_face_photo = GlaringFacePhoto.new
    end
  end

  def create
    @glaring_face_photo = current_user.glaring_face_photos.build(glaring_face_photo_params)
    if @glaring_face_photo.save
      redirect_to glaring_face_photos_path
    else
      render :new
    end
  end

  def index
    @glaring_face_photos = GlaringFacePhoto.all.order(id: :asc)
  end

  def update
    @glaring_face_photo.update(main_choiced: true)
    current_user.glaring_face_photos.where.not(id: params[:id]).each do |gfp|
     gfp.update(main_choiced: false)
    end
    redirect_to profile_path
  end

  def destroy
    @glaring_face_photo.destroy!
    redirect_to glaring_face_photos_path
  end

  def check
    # AWSレスポンス取得
    response = check_face
    # 判定ロジック
    # 顔写真が撮れているか
    if response.face_details != []
      response.face_details.each do |face_detail|

        # 目が開いているかつ笑顔ではない
        if face_detail.eyes_open.value == true && face_detail.emotions[0].type != 'HAPPY'

          # 眼力値の取得
          eye_power = params[:base].to_f

          # 感情値の取得
          (0..7).each do |i|
            if face_detail.emotions[i].type == 'ANGRY'
              @angry = face_detail.emotions[i].confidence
            end
            if face_detail.emotions[i].type == 'SAD'
              @sad = face_detail.emotions[i].confidence
            end
            if face_detail.emotions[i].type == 'CONFUSED'
              @confused = face_detail.emotions[i].confidence
            end
            if face_detail.emotions[i].type == 'CALM'
              @calm = face_detail.emotions[i].confidence * 0.1
            end
          end
          emotion_power = (@angry + @sad + @confused + @calm) / 4

          # 総合値の取得
          @result = eye_power * emotion_power

          render json: {
            body: '成功',
            face_score: @result
          }
        else
          render json: {
            body: '失敗',
            face_score: 0
          }
        end
      end
    else
      render json: {
        body: '失敗',
        face_score: 0
      }
    end
  end

  private

  def login_user
    unless logged_in?
      redirect_to login_path
    end
  end

  def find_glaring_face_photo
    @glaring_face_photo = current_user.glaring_face_photos.find(params[:id])
  end

  def glaring_face_photo_params
    params.require(:glaring_face_photo).permit(:image, :face_score)
  end
end
