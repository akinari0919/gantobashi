// /**
//  * "window.onload":ページの読み込みが完了したタイミングで処理が実行
//  * "document.querySelector":document全体に対して任意のHTML要素を検出・取得
//  */
// window.onload = () => {
//   const video  = document.querySelector("#camera");
//   const canvas = document.querySelector("#picture");

//   /** カメラ設定 */
//   const constraints = {
//     video: {
//       width: 300,
//       height: 400,
//       facingMode: "user"   // フロントカメラを利用する
//       // facingMode: { exact: "environment" }  // リアカメラを利用する場合
//     }
//   };

//   /**
//    * カメラを<video>と同期
//    */
//   navigator.mediaDevices.getUserMedia(constraints)
//   .then( (stream) => {
//     video.srcObject = stream;
//     video.onloadedmetadata = (e) => {
//       video.play();
//     };
//   })
//   .catch( (err) => {
//     console.log(err.name + ": " + err.message);
//   });

//   /**
//    * シャッターボタン
//    */
//   document.querySelector("#shutter").addEventListener("click", () => {
//     // 演出的な目的で一度映像を止める
//     video.pause();    // 映像を停止
//     setTimeout( () => {
//       video.play();    // 0.5秒後にカメラ再開
//     }, 500);

//     // (チェック用)canvasに画像を貼り付ける
//     const ctx = canvas.getContext("2d");
//     ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

//     // 画像データをcheck_controllerに渡す
//     const base64 = canvas.toDataURL('image/jpeg').replace(/data:.*\/.*;base64,/, '');
//     // alert(base64);

//     // var xhr = new XMLHttpRequest();
//     // xhr.open( 'POST', '/check');
//     // xhr.setRequestHeader( 'X-CSRF-Token', 'meta[name="csrf-token"]' );
//     // xhr.send();

//     $.ajax({
//       url: '/check',
//       type: 'POST',
//       data: {
//           image: base64
//         },
//       headers: {
//           'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
//         },
//     });
//   });
// };
