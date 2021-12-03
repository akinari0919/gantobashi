class TestController < ApplicationController
  def result
    uri = URI.parse("https://japanwest.api.cognitive.microsoft.com/face/v1.0/detect")
    uri.query = URI.encode_www_form({
      "returnFaceAttributes" => "emotion"
    })
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"

    params = { url: "https://i.gyazo.com/17ddb3ed59a19a0c9b01407224f03f7c.jpg" }
    headers = { 
      "Content-Type" => "application/json", 
      "Ocp-Apim-Subscription-Key" => "7cdc69350b194d509669f3bd3b6f88bb" 
    }
    response = http.post(uri, params.to_json, headers)
    
    # render json: response.body

    hash = JSON.parse(response.body)
    @result  = hash[0]["faceAttributes"]["emotion"]
  end
end
