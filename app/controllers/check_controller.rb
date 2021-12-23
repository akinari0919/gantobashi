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
    response = client.detect_faces attrs

    response.face_details.each do |face_detail|
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
    end




    # # URI指定
    # uri = URI.parse("https://japanwest.api.cognitive.microsoft.com/face/v1.0/detect")
    # uri.query = URI.encode_www_form({
    #   "returnFaceAttributes" => ["blur,exposure,noise,age,gender,facialhair,glasses,hair,makeup,accessories,occlusion,headpose,emotion,smile"]
    # })

    # # https通信の準備
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = uri.scheme === "https"
    # URI指定
    # uri = URI.parse("https://japanwest.api.cognitive.microsoft.com/face/v1.0/detect")
    # uri.query = URI.encode_www_form({
    #   "returnFaceAttributes" => "blur,exposure,noise,glasses,accessories,occlusion,emotion,smile"
    # })

    # # https通信の準備
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = uri.scheme === "https"
    
    # # 画像データをバイナリで渡す
    # body = Base64.decode64(params[:image])
    
    # # バイナリ形式でリクエスト
    # headers = { 
    #   "Content-Type" => "application/octet-stream",
    #   "Ocp-Apim-Subscription-Key" => ENV["API_KEY"]
    # }

    # # POSTした引数データのレスポンスを代入
    # response = http.post(uri, body, headers)

    # # # JSON形式でレスポンスを確認
    # render json: response.body

    # # JSONをviewで扱える形に代入
    # hash = JSON.parse(response.body)
    # @result = hash[0]["faceAttributes"]["emotion"]


    # # URLでリクエストする場合
    # uri = URI.parse("https://japanwest.api.cognitive.microsoft.com/face/v1.0/detect")
    # uri.query = URI.encode_www_form({
    #   "returnFaceAttributes" => "emotion"
    # })
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = uri.scheme === "https"

    # body = { url: "https://i.gyazo.com/17ddb3ed59a19a0c9b01407224f03f7c.jpg" }
    # headers = { 
    #   "Content-Type" => "application/json", 
    #   "Ocp-Apim-Subscription-Key" => ENV["API_KEY"]
    # }
    # response = http.post(uri, body.to_json, headers)

    # render json: response.body
  end
end
