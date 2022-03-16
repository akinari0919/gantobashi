[![Image from Gyazo](https://i.gyazo.com/900b2d9980232c075a0feb785600a0bf.png)](https://gyazo.com/900b2d9980232c075a0feb785600a0bf)
### サービスURL
### https://www.gantobashi.com/

<br>

---
## 概要
たまには悪ぶってみたい人が  
相手を威嚇し、ひよらせるという体験を通して  
ちょっとした優越感に浸れるサービスです。

<br>

### メインのターゲットユーザー
怒りで相手を威嚇するという感情表現を忘れた大人達

<br>

### ユーザーが抱える課題
- 相手によっては舐められてしまう
- 威圧的な人に動揺してしまうことがある

<br>

### 解決方法
- 自身のガン飛ばし力を可視化して自信を付けてもらう
- 結果を客観視しながら表情に磨きをかけることで、いざという時の備えにしてもらう

<br>

### サービス開発の背景
ある日「溝上さんって(営業していて)舐められやすいじゃないですか〜^^」と言われたことがありました。「誰にでも優しいってゆう意味ですよ//」とフォローはされましたが、確かに時には自身の意見を貫き通すために”舐められない”という要素は必要だと考えさせられました。そこで同じように人から舐められやすいかも？と感じている方向けに、睨みを効かせる相手にも動揺せず、負けずと睨み返すくらいの強い心を養えるサービスを作りたいと思いました。

<br>

---
## 実装済みの機能
ガン飛ばしの判定は`Amazon Recognition` & `Teachable Machines`を使用して独自のロジックを構築しています。  

#### `Amazon Recognition`
目が開いているか閉じているか&感情を判定するため採用

#### `Teachable Machines`
ガン飛ばしは怒り感情にまとまらないので、表情判定をカバーするために採用

<br>

### 診断モード
- 「〇〇人がひよった！」など個別の結果が表示される
- Twitterで自慢できる

|モード選択|撮影画面|診断詳細|
|---|---|---|
|[![Image from Gyazo](https://i.gyazo.com/0951111306b131ad0b44efb565a2cb2b.png)](https://gyazo.com/0951111306b131ad0b44efb565a2cb2b)|[![Image from Gyazo](https://i.gyazo.com/62febbcbfb53a1fa819a1c03ba9cd376.gif)](https://gyazo.com/62febbcbfb53a1fa819a1c03ba9cd376)|[![Image from Gyazo](https://i.gyazo.com/c05ab52c6e8959ac6eeccacc34b8b6d1.png)](https://gyazo.com/c05ab52c6e8959ac6eeccacc34b8b6d1)|

### 訓練モード
- Teachable Machinesで判定している睨み角度のコツを練習できる

|訓練画面|||
|---|---|---|
|[![Image from Gyazo](https://i.gyazo.com/dda3ae10d9335c8ae52df500403f6f79.gif)](https://gyazo.com/dda3ae10d9335c8ae52df500403f6f79)|||

### 決闘モード
- ユーザーログインが必要
- プロフィールからMyメンチを3つまで登録、公開できる
- 公開できるのは1枚だけで、挑戦者を返り討ちしたらそのメンチのレベルが上がる
- 他ユーザーが公開したメンチに対して決闘を挑んで勝敗を決める
- 勝敗によりユーザー(or相手メンチ)のレベルがあがる

|メンチ選択|決闘の流れ|勝敗判定|
|---|---|---|
|[![Image from Gyazo](https://i.gyazo.com/6a7a16e78420f48ca1944c758b994499.gif)](https://gyazo.com/6a7a16e78420f48ca1944c758b994499)|[![Image from Gyazo](https://i.gyazo.com/5f1d6b368a416570a4814cee422b97e1.gif)](https://gyazo.com/5f1d6b368a416570a4814cee422b97e1)|[![Image from Gyazo](https://i.gyazo.com/9e495f1d51dd3f6f7f199996108cddbb.gif)](https://gyazo.com/9e495f1d51dd3f6f7f199996108cddbb)|

### 管理画面
- 登録ユーザー情報を確認・編集できる
- ユーザーの決闘履歴が確認できる

<br>

### ★工夫ポイント★
- ガン飛ばし判定の精度を上げるため、目が閉じていたり笑顔の場合は失敗判定を出すようにしました。


- Myメンチは3つまで登録して公開メンチは選択した1つだけにできるようにしました。

`glaring_face_photo_controller.rb`
```rb
def update
  @glaring_face_photo.update(main_choiced: true)
  current_user.glaring_face_photos.where.not(id: params[:id]).each do |gfp|
    gfp.update(main_choiced: false)
  end
  redirect_to profile_path
end

def hide
  graring_face_photos = current_user.glaring_face_photos.all
  graring_face_photos.each do |gfp|
    gfp.update(main_choiced: false)
  end
  redirect_to profile_path
end
```

- 決闘に勝った場合はリンチ防止の為日付が変わるまで再戦できないようにしました。

`beat.rake`
```rb
# heroku schedulerで定期実行
namespace :beat do
  desc "全ての勝利ロックをリセットする"
  task reset_beats: :environment do
    Beat.all.delete_all
  end
end
```

<br>

### (今後の予定)
- 機能説明するためのガイド表示
- レベルによってランク名（総長etc.）を表示
- ランキング表示
- ライバル登録
- Twitter投稿時の動的OGP(公開選択式)
- 仮装ユーザーを管理画面から作成する機能
- 100人切りモード

<br>

---
## 使用技術
### バックエンド
- Ruby(3.0.3)
- Ruby on Rails(6.1.4.1)

### フロントエンド
- JavaScript
- jquery
- HTML
- CSS
- Bootstrap
- Font Awesome
- AdminLTE

### インフラ
- heroku
- PostgreSQL

<br>

---
## テーブル設計・ER図
[![Image from Gyazo](https://i.gyazo.com/75e2ac1ed7243511a5ac137e5f8f651e.png)](https://gyazo.com/75e2ac1ed7243511a5ac137e5f8f651e)

<br>

### Usersテーブル
- role  
管理者(Admin)権限をenumを使用して管理します。
- offense_win_count
他ユーザーに挑戦した決闘に勝利した数を記録します。

<br>

### Glaring_face_photosテーブル
ユーザーのガン飛ばし写真(Myメンチ)を登録するためのテーブルです。
- face_score  
戦闘力。他ユーザーと比較するために登録されます。
- defense_win_count  
他ユーザーに挑戦された決闘で返り討ちした数を記録します。

<br>

### Beats(打ち負かし)テーブル
他ユーザーに決闘して勝った場合は再戦できないようにロックするための中間テーブルです。  
※毎日０時にリセットされ再戦可能になります。

<br>

### BattleHistoriesテーブル
ユーザー同士の決闘履歴を残すテーブルです。  
管理画面でのみ戦闘力を表示できるようにしています。
