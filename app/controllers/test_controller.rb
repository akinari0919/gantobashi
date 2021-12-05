class TestController < ApplicationController
  def result
    uri = URI.parse("https://japanwest.api.cognitive.microsoft.com/face/v1.0/detect")
    uri.query = URI.encode_www_form({
      "returnFaceAttributes" => "emotion"
    })
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"
    
    # 画像データをバイナリ化
    body = Base64.strict_encode64(params[:image].read)
    headers = { 
      "Content-Type" => "application/octet-stream", # バイナリ形式でリクエスト
      "Ocp-Apim-Subscription-Key" => ENV["API_KEY"]
    }
    # POSTした引数データのレスポンスを代入
    response = http.post(uri, body, headers)
    
    # JSON形式でレスポンスを確認
    render json: response.body

  end
end
