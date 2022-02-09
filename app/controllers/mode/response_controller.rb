class Mode::ResponseController < ApplicationController
  include AwsRecognition

  def check
    # AWSレスポンス取得
    response = check_face

    # 判定ロジック
    # 顔写真が撮れているか
    if response.face_details == []
      render json: {
        body: '解析失敗m(_ _)m',
        star: "↓要確認↓",
        point1: "2人以上写っている場合や、",
        point2: "誰も写ってない場合など。",
        rank: "撮影不備の可能性あり"
      }
    else
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
            @angry = face_detail.emotions[i].confidence if face_detail.emotions[i].type == 'ANGRY'
            @sad = face_detail.emotions[i].confidence if face_detail.emotions[i].type == 'SAD'
            @confused = face_detail.emotions[i].confidence if face_detail.emotions[i].type == 'CONFUSED'
            @calm = face_detail.emotions[i].confidence * 0.1 if face_detail.emotions[i].type == 'CALM'
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
            @rank = case result
                    when 70
                      "参謀クラス"
                    when 72
                      "隊長クラス"
                    when 80
                      "(仮)総長クラス"
                    when 84
                      "総参謀クラス"
                    when 96
                      "裏総長クラス"
                    else
                      "総長代理クラス"
                    end
          elsif result_star >= 3
            @star = "★★★☆☆"
            result = 32 if result <= 30
            @rank = if result < 40
                      "特攻隊長クラス"
                    elsif result < 50
                      "隊長代理クラス"
                    elsif result < 60
                      "副隊長クラス"
                    else
                      "幹部クラス"
                    end
          elsif result_star >= 2
            @star = "★★☆☆☆"
            result = 20 if result == 6 && @emotion_star > @eye_star
            if result <= 5
              result *= 3
            elsif result <= 10
              result *= 2
            end
            @rank = if result < 20
                      "特攻隊クラス"
                    elsif result == 20
                      "相談役クラス"
                    else
                      "親衛隊長クラス"
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
            @rank = if result > 0.4
                      "三下クラス"
                    else
                      "雑魚クラス"
                    end
          end

          # 結果を反映
          @comment = if result.floor > 100
                       {
                         body: "#{result.floor}人をひよらせた!!!",
                         star: @star,
                         point1: "眼力：#{@eye_result}",
                         point2: "感情値：#{@emotion_result}",
                         rank: "総長クラス"
                       }
                     elsif result.floor == 100
                       {
                         body: "#{result.floor}人をひよらせた!!",
                         star: @star,
                         point1: "眼力：#{@eye_result}",
                         point2: "感情値：#{@emotion_result}",
                         rank: "副総長クラス"
                       }
                     elsif result.floor >= 1
                       {
                         body: "#{result.floor}人をひよらせた！",
                         star: @star,
                         point1: "眼力：#{@eye_result}",
                         point2: "感情値：#{@emotion_result}",
                         rank: @rank
                       }
                     else
                       {
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
    end
  end

  def training
    # AWSレスポンス取得
    response = check_face

    # 顔写真が撮れているか
    if response.face_details == []
      @comment = {
        body: "失敗orz"
      }
    else
      response.face_details.each do |face_detail|
        # 目が開いているかつ笑顔ではない
        @comment = if face_detail.eyes_open.confidence >= 85 && face_detail.emotions[0].type != 'HAPPY'
                     {
                       body: "成功◎その調子!!"
                     }
                   else
                     {
                       body: "失敗orz(惜しい！)"
                     }
                   end
      end
    end
    render json: @comment
  end
end
