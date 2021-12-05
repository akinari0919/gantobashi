## ■概要(実現したいこと)

画像データを保存せずに、直接FaceAPI([参照](https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236))へ顔画像をリクエストして感情データを取得したいと考えています。

<br>

## ■現状発生している問題・エラーメッセージ
- 画像データをBase64形式でAPIに渡そうとするとリクエストが不正になってしまいます。
```
[4] pry(#<TestController>)> response
=> #<Net::HTTPBadRequest 400 Bad Request readbody=true>
```

[![Image from Gyazo](https://i.gyazo.com/b2b770768a67fade0bb79ced74651f56.gif)](https://gyazo.com/b2b770768a67fade0bb79ced74651f56)

[(公式参照)](https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236)
[![Image from Gyazo](https://i.gyazo.com/21d2e7cb6b7f2103e0ae3dbda0775b01.png)](https://gyazo.com/21d2e7cb6b7f2103e0ae3dbda0775b01)

<br>

## ■どの処理までうまく動いているのか
- Face APIからレスポンスは返って来ているのでAPI処理は動いていると思います。
- 画像データはBase64形式に変換されています。
```
1] pry(#<TestController>)> body
=> "/9j/4AAQSkZJRgABAQAAAQABAAD/4g...(省略)
```

<br>

## ■該当コード
`app/views/home/top.html.slim`
```ruby
p
  | Let's ☆ ガン飛ばし
h1
  | メンチキッター

= form_with url: test_path do |f|
  = f.file_field :image
  = f.submit 'ガン飛ばす'
```

`app/controllers/test_controller.rb`
```ruby
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
    body = Base64.strict_encode64(params[:image].read)
    
    # バイナリ形式でリクエスト
    headers = { 
      "Content-Type" => "application/octet-stream",
      "Ocp-Apim-Subscription-Key" => ENV["API_KEY"]
    }

    # POSTした引数データのレスポンスを代入
    response = http.post(uri, body, headers)
    
    # JSON形式でレスポンスを確認
    render json: response.body

  end
end
```
`config/routes.rb`
```ruby
Rails.application.routes.draw do
  root 'home#top'
  post 'test', to: 'test#result'
end
```

<br>

## ■エラーから考えられる原因
- 公式のお試し([参照](https://japanwest.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236/console))でBase64変換された画像データをベタ張りしても同じエラーレスポンスだったので、
バイナリデータの渡し方が間違っているのかなと考えています。
[![Image from Gyazo](https://i.gyazo.com/165b7fdf0afe85accd07d5756227621f.png)](https://gyazo.com/165b7fdf0afe85accd07d5756227621f)

<br>

## ■試したこと

- データ型を追記してリクエストしてみました。  
```ruby
body = "data:image/jpg;base64,#{Base64.strict_encode64(params[:image].read)}"
```
→ エラー内容は変わりませんでした。

- url形式を直書きでリクエスト送信した場合は正常に返ってきました。
```ruby
uri = URI.parse("https://japanwest.api.cognitive.microsoft.com/face/v1.0/detect")
uri.query = URI.encode_www_form({
  "returnFaceAttributes" => "emotion"
})
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = uri.scheme === "https"

body = { url: "https://i.gyazo.com/17ddb3ed59a19a0c9b01407224f03f7c.jpg" }
headers = { 
  "Content-Type" => "application/json", 
  "Ocp-Apim-Subscription-Key" => ENV["API_KEY"]
}
response = http.post(uri, body.to_json, headers)

render json: response.body
```
[![Image from Gyazo](https://i.gyazo.com/47a136aacdfea53e31a4c859f1ceff99.png)](https://gyazo.com/47a136aacdfea53e31a4c859f1ceff99)

<br>

## ■参考にしたURL
- [Face API - v1.0(公式)](https://japanwest.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236/console)
- [Azure face APIで遊んでみよう　その１~顔の検出](https://qiita.com/haseshin/items/04a482976f78a178bed4)
[![Image from Gyazo](https://i.gyazo.com/c1b90107536b8eb999cf4b9c653b5a48.png)](https://gyazo.com/c1b90107536b8eb999cf4b9c653b5a48)
- [上記リンク先(How to post an image in base64 encoding via .ajax?)※JS記事](https://stackoverflow.com/questions/34047648/how-to-post-an-image-in-base64-encoding-via-ajax/34064793#34064793)
