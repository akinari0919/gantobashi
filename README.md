[![Image from Gyazo](https://i.gyazo.com/900b2d9980232c075a0feb785600a0bf.png)](https://gyazo.com/900b2d9980232c075a0feb785600a0bf)
### サービスURL
### https://www.gantobashi.com/

<br>

---
## 🔹概要🔹
たまには悪ぶってみたい人が  
相手を威嚇し、ひよらせるという体験を通して  
ちょっとした優越感に浸れるサービスです。

<br>

### 🔻メインのターゲットユーザー
怒りで相手を威嚇するという感情表現を忘れた大人達

<br>

### 🔻ユーザーが抱える課題
- 相手によっては舐められてしまう
- 威圧的な人に動揺してしまうことがある

<br>

### 🔻解決方法
- 自身のガン飛ばし力を可視化して自信を付けてもらう
- 結果を客観視しながら表情に磨きをかけることで、いざという時の備えにしてもらう

<br>

### 🔻サービス開発の背景
個人的にムッ...！っと思っていてもTPO的にニコニコ^^としていることが多い人間だったのですが、これが人によっては舐められてしまう要因になることが分かり、時には睨みを効かすことの大事さを悟り、いざという時の為の練習環境になればという考えに至り本サービスを開発することにしました。

<br>

## 🔹実装済みの機能🔹
ガン飛ばしをテーマにコンテンツ型のサービスとして現在3つのモードをリリースしています。

|診断モード|訓練モード|決闘モード|
|---|---|---|
|[![Image from Gyazo](https://i.gyazo.com/62febbcbfb53a1fa819a1c03ba9cd376.gif)](https://gyazo.com/62febbcbfb53a1fa819a1c03ba9cd376)|[![Image from Gyazo](https://i.gyazo.com/dda3ae10d9335c8ae52df500403f6f79.gif)](https://gyazo.com/dda3ae10d9335c8ae52df500403f6f79)|[![Image from Gyazo](https://i.gyazo.com/9e495f1d51dd3f6f7f199996108cddbb.gif)](https://gyazo.com/9e495f1d51dd3f6f7f199996108cddbb)|
|ガン飛ばしの怖さを可視化できます。|高い点数判定を出すコツを掴めます。|他ユーザーと闘えます。<br>(ユーザー登録が必要)|

### 🔻診断モード
- 「〇〇人がひよった！」など個別の結果が表示される
- 結果に応じてランクが設定されていて最高ランクは"総長クラス"(120人ひよると出現)
- 結果をTwitterで拡散可能

後述のTeachable Machinesで取得した眼力値とAmazon Rekognitionで取得した感情値をそれぞれの数値に応じてレベル0(☆☆☆☆☆)からレベル5(★★★★★)に振り分け、かつレベル毎に設定した人数と掛け合わせることで総合値とランクを算出・設定しています。
※ランクと人数が矛盾しないように一部微調整しています。
[![Image from Gyazo](https://i.gyazo.com/0149c6bb8b3552d592eb01fe139f1b6b.png)](https://gyazo.com/0149c6bb8b3552d592eb01fe139f1b6b)
（実は感情のレベルは見た目では5までなのですが、実質6まで存在しています）

### 🔻訓練モード
- 撮影判定のうち睨み角度（眼力）のコツを練習できる
- ★が5つ揃えば自動撮影
- ★が揃っても目を閉じている、笑っている、顔が写っていないなどは失敗になる

|目を閉じている|笑っている|顔が写っていない|
|----|----|----|
|[![Image from Gyazo](https://i.gyazo.com/bb849daccfdbd062e6b0fe706e3835ae.png)](https://gyazo.com/bb849daccfdbd062e6b0fe706e3835ae)|[![Image from Gyazo](https://i.gyazo.com/3456e5ea618ee26c900ccedb5b580b5f.png)](https://gyazo.com/3456e5ea618ee26c900ccedb5b580b5f)|[![Image from Gyazo](https://i.gyazo.com/8e10ee191fe753882082d117c38904bb.png)](https://gyazo.com/8e10ee191fe753882082d117c38904bb)|

### 🔻決闘モード
- ユーザーログインが必要
- プロフィールからMyメンチを3つまで登録、公開できる
- 公開できるのは1枚だけで、挑戦者を返り討ちしたらそのメンチのレベルが上がる
- 他ユーザーが公開したメンチに対して決闘を挑んで勝敗を決める
- 勝敗によりユーザー(or相手メンチ)のレベルが上がる

|メンチ選択|決闘の流れ|勝敗判定|
|---|---|---|
|[![Image from Gyazo](https://i.gyazo.com/6a7a16e78420f48ca1944c758b994499.gif)](https://gyazo.com/6a7a16e78420f48ca1944c758b994499)|[![Image from Gyazo](https://i.gyazo.com/5f1d6b368a416570a4814cee422b97e1.gif)](https://gyazo.com/5f1d6b368a416570a4814cee422b97e1)|[![Image from Gyazo](https://i.gyazo.com/9e495f1d51dd3f6f7f199996108cddbb.gif)](https://gyazo.com/9e495f1d51dd3f6f7f199996108cddbb)|

### 🔻(その他)管理画面
- 登録ユーザー情報を確認・編集できる
- ユーザーの決闘履歴が確認できる

<br>

## 🔹ガン飛ばしの判定方法について🔹
`Amazon Rekognition`&`Teachable Machines`を使用して独自のロジックを構築  

<details>
<summary>Amazon Rekognition</summary>
<div>

https://aws.amazon.com/jp/rekognition/

目が開いているか閉じているか&感情を判定するため採用
開発当初はFaceAPIを使用していましたが、ガン飛ばし判定にリアリティを持たせるには目の開閉判定が必要になり変更しました。

</div>
</details>

<details>
<summary>Teachable Machines</summary>
<div>

https://teachablemachine.withgoogle.com/

ガン飛ばしは怒り感情にまとまらないので、表情判定をカバーするために採用
おかげで眉間に皺寄せを（実際クセがありますが）判定として導入できました。

[![Image from Gyazo](https://i.gyazo.com/1a04f64da0c19ceb7fa4e4451ca0c6f0.gif)](https://gyazo.com/1a04f64da0c19ceb7fa4e4451ca0c6f0)

</div>
</details>

現状の撮影〜データ取得までの流れは以下のような仕様になっています。
[![Image from Gyazo](https://i.gyazo.com/8deae3924a0310d90bf88ae259ac751d.gif)](https://gyazo.com/8deae3924a0310d90bf88ae259ac751d)

<br>

## 🔹工夫ポイント3つ🔹
### ① Myメンチ登録以外でのガン飛ばし撮影データはDB保存しない
撮影データはJavascript上でBase64変換していてモード毎のControllerへajax送信しています。
さらにAmazon Rekognitionへ送信する際にBase64からデコードすることでDBへ保存することなくレスポンスを受け取る形を実現しています。

◉フロントから受け取った撮影データをAmazon Rekognitionへバイナリ送信しているコード
現状concernsへモジュールとして切り出ししています。

`app/controllers/concerns/aws_rekognition.rb`
```rb
module AwsRekognition
  extend ActiveSupport::Concern

  def check_face
    credentials = Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'],
      ENV['AWS_SECRET_ACCESS_KEY']
    )
    photo = Base64.decode64(params[:image]) # <= ここでデコード
    client = Aws::Rekognition::Client.new credentials: credentials
    attrs = {
      image: {
        bytes: photo
      },
      attributes: ['ALL']
    }
    return client.detect_faces attrs
  end
end
```

### ② Myメンチ登録数は3つに限定、公開メンチは選択した1つに限定
強いメンチは記念に残しながら、新しいメンチで遊び直すことも可能にしてみました。
|Myメンチ一覧|3つになった場合|1つだけ選択(公開)できる|
|---|---|---|
|[![Image from Gyazo](https://i.gyazo.com/5c8ee4018fe4b9eb379a614799c59db3.png)](https://gyazo.com/5c8ee4018fe4b9eb379a614799c59db3)|[![Image from Gyazo](https://i.gyazo.com/4c45be21cf87b29429e12b5062fea5ae.png)](https://gyazo.com/4c45be21cf87b29429e12b5062fea5ae)|[![Image from Gyazo](https://i.gyazo.com/2a343c0135025b4ebc027bc773adc076.png)](https://gyazo.com/2a343c0135025b4ebc027bc773adc076)|
|追加ボタンより撮影・登録画面へアクセスが可能です。|追加・直接撮影画面へのアクセスも出来なくなります。|公開中メンチはプロフィール画面の下に表示されます。|

◉公開メンチ設定用のコード
メンチテーブル(GlaringFacePhotos)に公開設定カラム(main_choiced)を追加することで実現
選択メンチをtrueにして他は`each do`で回しながらfalseにしています。

`app/controllers/glaring_face_photo_controller.rb`
```rb
 before_action :find_glaring_face_photo, only: [:update, :destroy]

 # 選択したメンチを公開すると選択されていないメンチを非公開にする
 def update
   @glaring_face_photo.update(main_choiced: true)
   current_user.glaring_face_photos.where.not(id: params[:id]).each do |gfp|
     gfp.update(main_choiced: false)
   end
   redirect_to profile_path
 end

 # 非公開ボタンで全てのメンチを非公開にする
 def hide
   graring_face_photos = current_user.glaring_face_photos.all
   graring_face_photos.each do |gfp|
     gfp.update(main_choiced: false)
   end
   redirect_to profile_path
 end

 private

 def find_glaring_face_photo
   @glaring_face_photo = current_user.glaring_face_photos.find(params[:id])
 end
```

#### ③ 決闘に勝った場合はリンチ防止の為日付が変わるまで再戦不可にする
勝てる相手に何度も挑んでいたらリンチになってしまうので、その防止策として同じ相手に勝てるのは1日1回までに限定しました。

|決闘前|決闘で勝利した場合ロック|0時を回ったらロック解除|
|---|---|---|
|[![Image from Gyazo](https://i.gyazo.com/107c45fdf0375dc3778c3b9aedaf7464.png)](https://gyazo.com/107c45fdf0375dc3778c3b9aedaf7464)|[![Image from Gyazo](https://i.gyazo.com/c1b65f200e06a9df6fc5f1e05266c963.png)](https://gyazo.com/c1b65f200e06a9df6fc5f1e05266c963)|[![Image from Gyazo](https://i.gyazo.com/107c45fdf0375dc3778c3b9aedaf7464.png)](https://gyazo.com/107c45fdf0375dc3778c3b9aedaf7464)|

◉勝った場合に再戦不可にしているコード
勝利した場合にUserとGlaringFacePhoto(相手のメンチ)の中間モデルを作成
※ここではBeats(打ち負かし)テーブルとして扱っています。

`app/controller/mode/batlle_controller.rb`
```rb
def result
  user = User.find(params[:enemy_id])
  gfp = user.glaring_face_photos.find_by(main_choiced: true)

  if 省略
  # 勝った場合
  elsif params[:enemy_score].to_i < params[:my_score].to_i
    省略
    # 再戦不可にする
    gfp.beats.create(user_id: current_user.id)
    省略
  end
end
```

◉日付を跨いだ時点で再戦可能にするコード
全てのロックを解除するタスクを作成して定期実行させています。

`lib/tasks/beat.rake`
```rb
 # heroku schedulerで毎0時に定期実行
 namespace :beat do
   desc "全ての勝利ロックをリセットする"
   task reset_beats: :environment do
     Beat.all.delete_all
   end
 end
```

<br>

## 🔹今後の予定🔹
- 機能説明するためのガイド表示
- レベルによってランク名（総長etc.）を表示
- ランキング表示
- ライバル登録
- Twitter投稿時の動的OGP(公開選択式)
- 仮装ユーザーを管理画面から作成する機能
- 100人切りモード

etc.

<br>

## 🔹使用技術🔹
### 🔻バックエンド
- Ruby(3.0.3)
- Ruby on Rails(6.1.4.1)

### 🔻Gem
- sorcery
- kaminari
- meta-tags
- aws-sdk-rekognition
- dotenv-rails
- rails-i18n

### 🔻フロント
- JavaScript
- jquery
- HTML
- CSS
- Bootstrap
- Font Awesome
- AdminLTE

### 🔻インフラ
- heroku
- PostgreSQL

<br>

## 🔹テーブル設計・ER図🔹
決闘モードで使用しているモデルです。
[![Image from Gyazo](https://i.gyazo.com/75e2ac1ed7243511a5ac137e5f8f651e.png)](https://gyazo.com/75e2ac1ed7243511a5ac137e5f8f651e)


### 🔻Usersテーブル
- `role`：管理者(Admin)権限をenumを使用して管理します。
- `offense_win_count`：他ユーザーに挑戦した決闘に勝利した数を記録します。

### 🔻GlaringFacePhotosテーブル
ユーザーのガン飛ばし写真(Myメンチ)を登録するためのテーブルです。
- `face_score`：戦闘力。他ユーザーと比較するために登録されます。
- `defense_win_count`：他ユーザーに挑戦された決闘で返り討ちした数を記録します。
- `main_choiced`：公開用メンチに選択されているかを管理します。

### 🔻Beats(打ち負かし)テーブル
他ユーザーに決闘して勝った場合は再戦できないようにロックするための中間テーブルです。  
※毎日0時にリセットされ再戦可能になります。

### 🔻BattleHistoriesテーブル
ユーザー同士の決闘履歴を残すテーブルです。  
管理画面でのみ戦闘力を表示できるようにしています。

<br>

## 🔹その他🔹
### 🔻実績（3月30日時点）
- 累計412UU（4018PV）
- Qiita記事：63LGTM（5765views）
https://qiita.com/Akinari0919/items/87870b807f2f179da9d0
