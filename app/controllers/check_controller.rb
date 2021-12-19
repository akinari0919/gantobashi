class CheckController < ApplicationController
  def result
    # URI指定
    uri = URI.parse("https://japanwest.api.cognitive.microsoft.com/face/v1.0/detect")
    uri.query = URI.encode_www_form({
      "returnFaceAttributes" => "blur,exposure,noise,glasses,accessories,occlusion,emotion,smile"
    })

    # https通信の準備
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"
    
    # 画像データをバイナリで渡す
    body = Base64.decode64(params[:image])
    
    # バイナリ形式でリクエスト
    headers = { 
      "Content-Type" => "application/octet-stream",
      "Ocp-Apim-Subscription-Key" => ENV["API_KEY"]
    }

    # POSTした引数データのレスポンスを代入
    response = http.post(uri, body, headers)

    # # JSON形式でレスポンスを確認
    render json: response.body

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
