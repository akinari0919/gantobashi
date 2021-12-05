class TestController < ApplicationController
  def result
    # URI指定
    uri = URI.parse("https://japanwest.api.cognitive.microsoft.com/face/v1.0/detect")
    uri.query = URI.encode_www_form({
      "returnFaceAttributes" => "emotion"
    })
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"
    
    # 画像データをバイナリ化
    body = params[:image].read
    
    # バイナリ形式でリクエスト
    headers = { 
      "Content-Type" => "application/octet-stream",
      "Ocp-Apim-Subscription-Key" => ENV["API_KEY"]
    }

    # POSTした引数データのレスポンスを代入
    response = http.post(uri, body, headers)
    
    # # JSON形式でレスポンスを確認
    # render json: response.body

    hash = JSON.parse(response.body)
    @result  = hash[0]["faceAttributes"]["emotion"]

    # # URL
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
