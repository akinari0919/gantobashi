class CheckController < ApplicationController
  def result
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

    # 判定ロジック
    response = client.detect_faces attrs
    response.face_details.each do |face_detail|
      if face_detail.eyes_open.value == true && face_detail.smile.value == false
        # 感情値の取得
        (0..7).each do |i|
          if face_detail.emotions[i].type == 'ANGRY'
            @angry = face_detail.emotions[i].confidence
          end
          if face_detail.emotions[i].type == 'CONFUSED'
            @confused = face_detail.emotions[i].confidence
          end
        end

        # 怒りの感情を優遇 
        if @angry > @confused
          result = @angry.ceil * @confused.ceil * 1.1
        else
          result = @angry.ceil * @confused.ceil * 0.5
        end

        # 補正
        if result > 1000
          result *= 0.1
        end
        
        # 結果を反映
        if result.floor > 0
          @comment = "#{result.floor}人がひよった！"
          render body: @comment
        else
          @comment = "誰一人ひよらない、、"
          render body: @comment
        end
      else
        render body: "なっとらん！"
      end

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
      puts "------------"
      puts ""
    end
  end
end
