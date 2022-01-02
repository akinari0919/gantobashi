class CheckController < ApplicationController
  before_action :not_user, {only: :show}

  def result
    # AWSレスポンス取得
    credentials = Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'],
      ENV['AWS_SECRET_ACCESS_KEY']
    )
    photo = Base64.decode64(params[:image])
    client = Aws::Rekognition::Client.new credentials: credentials
    attrs = {
      image: { 
        bytes: photo
      },
      attributes: ['ALL']
    }

    response = client.detect_faces attrs
    # 判定ロジック

    # 顔写真が撮れているか
    if response.face_details != []
      response.face_details.each do |face_detail|

        # 目が開いているかつ笑顔ではない
        if face_detail.eyes_open.value == true && face_detail.smile.value == false

          # 眼力値の取得
          eye_power = params[:base].to_f
          if eye_power >= 99.99
            @eye_result = "★★★★★"
            eye_power = 5
            @eye_star = 5
          elsif eye_power >= 99.9
            @eye_result = "★★★★☆"
            eye_power = 4
            @eye_star = 4
          elsif eye_power >= 99.5
            @eye_result = "★★★☆☆"
            eye_power = 3.5
            @eye_star = 3
          elsif eye_power >= 99
            @eye_result = "★★★☆☆"
            eye_power = 3
            @eye_star = 3
          elsif eye_power >= 95
            @eye_result = "★★★☆☆"
            eye_power = 2
            @eye_star = 3
          elsif eye_power >= 90
            @eye_result = "★★☆☆☆"
            eye_power = 1.5
            @eye_star = 2
          elsif eye_power >= 80
            @eye_result = "★☆☆☆☆"
            eye_power = 1
            @eye_star = 1
          else
            @eye_result = "☆☆☆☆☆"
            eye_power = 0
            @eye_star = 0
          end

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
          if emotion_power >= 24.9
            @emotion_result = "★★★★★"
            @emotion_star = 5
            emotion_power = 25
          elsif emotion_power >= 24
            @emotion_result = "★★★★★"
            @emotion_star = 5
            emotion_power = 20
          elsif emotion_power >= 20
            @emotion_result = "★★★★☆"
            @emotion_star = 4
            emotion_power = 15
          elsif emotion_power >= 15
            @emotion_result = "★★★☆☆"
            @emotion_star = 3
            emotion_power = 10
          elsif emotion_power >= 5
            @emotion_result = "★★☆☆☆"
            @emotion_star = 2
            emotion_power = 5
          elsif emotion_power >= 1
            @emotion_result = "★☆☆☆☆"
            @emotion_star = 1
            emotion_power = 1
          else
            @emotion_result = "☆☆☆☆☆"
            @emotion_star = 0
            emotion_power = 0
          end

          # 総合値の取得
          result = eye_power * emotion_power
          result_star = (@eye_star + @emotion_star) / 2
          if result_star >= 5
            @star = "★★★★★"
          elsif result_star >= 4
            @star = "★★★★☆"
            @rank = "隊長クラス"
          elsif result_star >= 3
            @star = "★★★☆☆"
            @rank = "副隊長クラス"
          elsif result_star >= 2
            @star = "★★☆☆☆"
            @rank = "特攻隊クラス"
          else
            @star = "★☆☆☆☆"
            @rank = "旗持ちクラス"
          end

          if result.floor > 100
            @comment = { 
              body: "#{result.floor}人をひよらせた!!!",
              star: @star,
              point1: "眼力：#{@eye_result}",
              point2: "感情値：#{@emotion_result}",
              rank: "総長クラス"
            }
          elsif result.floor == 100
            @comment = { 
              body: "#{result.floor}人をひよらせた!!",
              star: @star,
              point1: "眼力：#{@eye_result}",
              point2: "感情値：#{@emotion_result}",
              rank: "副総長クラス"
            }
          elsif result.floor >= 1
            @comment = { 
              body: "#{result.floor}人をひよらせた！",
              star: @star,
              point1: "眼力：#{@eye_result}",
              point2: "感情値：#{@emotion_result}",
              rank: @rank
            }
          else
            @comment = {
              body: "誰一人ひよらない(泣)",
              star: "☆☆☆☆☆",
              point1:"眼力：☆☆☆☆☆",
              point2:"感情値：☆☆☆☆☆",
              rank: "雑魚クラス"
            }
          end
        else
          @comment = {
            body: "ガン飛んでないorz",
            star: "☆☆☆☆☆",
            point1:"目閉じてない？",
            point2:"笑ってない？",
            rank: "モブ以下"
          }
        end

        render json: @comment

        # レスポンス確認用
        puts "------------"
        puts ""
        puts "The detected face is between: #{face_detail.age_range.low} and #{face_detail.age_range.high} years old"
        puts ""
        puts "  eyes_open.value:        #{face_detail.eyes_open.value}"
        puts "  eyes_open.confidence:   #{face_detail.eyes_open.confidence}"
        puts "  smile.value:            #{face_detail.smile.value}"
        puts "  smile.confidence:       #{face_detail.smile.confidence}"
        puts ""
        puts "------------"
        puts ""
        puts "  eyeglasses.value:       #{face_detail.eyeglasses.value}"
        puts "  eyeglasses.confidence:  #{face_detail.eyeglasses.confidence}"
        puts "  sunglasses.value:       #{face_detail.sunglasses.value}"
        puts "  sunglasses.confidence:  #{face_detail.sunglasses.confidence}"
        puts "  mouth_open.value:       #{face_detail.mouth_open.value}"
        puts "  mouth_open.confidence:  #{face_detail.mouth_open.confidence}"
        puts ""
        puts "------------"
        puts ""
        puts "  quality.brightness:     #{face_detail.quality.brightness}"
        puts "  quality.sharpness:      #{face_detail.quality.sharpness}"
        puts "  confidence:             #{face_detail.confidence}"
        puts ""
        puts "------------"
        puts ""
        puts "  【#{face_detail.emotions[0].type}】"
        puts "    #{face_detail.emotions[0].confidence}"
        puts "  【#{face_detail.emotions[1].type}】"
        puts "    #{face_detail.emotions[1].confidence}"
        puts "  【#{face_detail.emotions[2].type}】"
        puts "    #{face_detail.emotions[2].confidence}"
        puts "  【#{face_detail.emotions[3].type}】"
        puts "    #{face_detail.emotions[3].confidence}"
        puts "  【#{face_detail.emotions[4].type}】"
        puts "    #{face_detail.emotions[4].confidence}"
        puts "  【#{face_detail.emotions[5].type}】"
        puts "    #{face_detail.emotions[5].confidence}"
        puts "  【#{face_detail.emotions[6].type}】"
        puts "    #{face_detail.emotions[6].confidence}"
        puts "  【#{face_detail.emotions[7].type}】"
        puts "    #{face_detail.emotions[7].confidence}"
        puts ""
        puts params[:base].to_f
        puts @eye_result
        puts emotion_power
        puts @emotion_result
        puts "------------"
        puts ""
      end
    else
      render json: {
        body: '解析失敗m(_ _)m',
        star: "ご確認ください。",
        point1:"2人以上写っている場合や、",
        point2:"誰も写ってない場合など。",
        rank:"撮影不備の可能性あり"
      }
    end
  end

  def show
    @body = params[:body]
    @star = params[:star]
    @photo = params[:photo]
    @point1 = params[:point1]
    @point2 = params[:point2]
    @rank = params[:rank]
  end

  def not_user
    if params[:body] == nil
      redirect_to("/select")
    end
  end
end
