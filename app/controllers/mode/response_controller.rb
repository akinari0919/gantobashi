class Mode::ResponseController < ApplicationController
  include AwsRecognition

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
          if eye_power > 99.98
            @eye_result = "★★★★★"
            @eye_star = 5
            eye_power = 10
          elsif eye_power > 99.8
            @eye_result = "★★★★☆"
            @eye_star = 4
            eye_power = 8
          elsif eye_power > 98.5
            @eye_result = "★★★☆☆"
            @eye_star = 3
            eye_power = 7
          elsif eye_power > 97.5
            @eye_result = "★★☆☆☆"
            @eye_star = 2
            eye_power = 4
          elsif eye_power > 75
            @eye_result = "★☆☆☆☆"
            @eye_star = 1
            eye_power = 1
          else
            @eye_result = "☆☆☆☆☆"
            @eye_star = 0
            eye_power = 0.5
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
          if emotion_power > 24.9
            @emotion_result = "★★★★★"
            @emotion_star = 5
            @emotion_power = 12
          elsif emotion_power > 24.7
            @emotion_result = "★★★★★"
            @emotion_star = 5
            @emotion_power = 10
          elsif emotion_power > 24
            @emotion_result = "★★★★☆"
            @emotion_star = 4
            @emotion_power = 9
          elsif emotion_power > 18
            @emotion_result = "★★★☆☆"
            @emotion_star = 3
            @emotion_power = 8
          elsif emotion_power > 15
            @emotion_result = "★★☆☆☆"
            @emotion_star = 2
            @emotion_power = 4
          elsif emotion_power > 8
            @emotion_result = "★☆☆☆☆"
            @emotion_star = 1
            @emotion_power = 1
          else
            @emotion_result = "☆☆☆☆☆"
            @emotion_star = 0
            @emotion_power = 0.5
          end

          # 総合値の取得
          result = eye_power * @emotion_power
          result_star = (@eye_star + @emotion_star) / 2

          if result_star >= 5
            @star = "★★★★★"
          elsif result_star >= 4
            @star = "★★★★☆"
            if result == 70
              @rank = "参謀クラス"
            elsif result == 72
              @rank = "隊長クラス"
            elsif result == 80
              @rank = "(仮)総長クラス"
            elsif result == 84
              @rank = "総参謀クラス"
            elsif result == 96
              @rank = "裏総長クラス"
            else
              @rank = "総長代理クラス"
            end
          elsif result_star >= 3
            @star = "★★★☆☆"
            if result <= 30
              result = 32
            end
            if result < 40
              @rank = "特攻隊長クラス"
            elsif result < 50
              @rank = "隊長代理クラス"
            elsif result < 60
              @rank = "副隊長クラス"
            else
              @rank = "幹部クラス"
            end
          elsif result_star >= 2
            @star = "★★☆☆☆"
            if result == 6 && @emotion_star > @eye_star
              result = 20
            end
            if result <= 5
              result *= 3
            elsif result <= 10
              result *= 2
            end
            if result < 20
              @rank = "特攻隊クラス"
            elsif result == 20
              @rank = "相談役クラス"
            else
              @rank = "親衛隊長クラス"
            end
          elsif result_star >= 1
            @star = "★☆☆☆☆"
            if @eye_star > @emotion_star
              @rank = "隊員クラス"
              result *= 2
            elsif @eye_star == @emotion_star
              @rank = "旗持ちクラス"
            else
              @rank = "親衛隊クラス"
              result *= 2
            end
          else
            @star = "☆☆☆☆☆"
            if result == 0
              @rank = "雑魚クラス"
            else
              @rank = "三下クラス"
            end
          end

          # 結果を反映
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
              star: @star,
              point1: "眼力：#{@eye_result}",
              point2: "感情値：#{@emotion_result}",
              rank: @rank
            }
          end
        else
          @comment = {
            body: "ガン飛んでないorz",
            star: "☆☆☆☆☆",
            point1: "目閉じてない？",
            point2: "笑ってない？",
            rank: "モブ以下"
          }
        end

        render json: @comment
      end
    else
      render json: {
        body: '解析失敗m(_ _)m',
        star: "↓要確認↓",
        point1: "2人以上写っている場合や、",
        point2: "誰も写ってない場合など。",
        rank: "撮影不備の可能性あり"
      }
    end
  end

  def training
    # AWSレスポンス取得
    response = check_face

    # 顔写真が撮れているか
    if response.face_details != []
      response.face_details.each do |face_detail|
        # 目が開いているかつ笑顔ではない
        if face_detail.eyes_open.confidence >= 85 && face_detail.emotions[0].type != 'HAPPY'
          @comment = {
            body: "成功◎その調子!!"
          }
        else
          @comment = {
            body: "失敗orz(惜しい！)"
          }
        end
      end
    else
      @comment = {
        body: "失敗orz"
      }
    end
    render json: @comment
  end
end
