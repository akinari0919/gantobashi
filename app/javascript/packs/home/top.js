$('#canvas').hide();
$('#reload').hide();
// カメラ設定
const constraints = {
  video: {
    width: 300,
    height: 300,
    facingMode: "user"   // フロントカメラを利用する
  }
};

// カメラを<video>と同期
navigator.mediaDevices.getUserMedia(constraints)
.then( (stream) => {
  video.srcObject = stream;
  video.onloadedmetadata = (e) => {
    video.play();
  };
})
.catch( (err) => {
  console.log(err.name + ": " + err.message);
});

const URL = "https://teachablemachine.withgoogle.com/models/3tSiNOSPs/";

let model, labelContainer, maxPredictions;

async function init() {
  document.getElementById('shatter').disabled = true;
  $('#video').hide();
  $('#canvas').show();
  $(this).html( $(this).data('loading-text') );
  
  // canvasに静止画を入れる
  var canvas = document.getElementById("canvas")
  canvas.getContext("2d").drawImage(video, 0, 0, 300, 300)

  // teachablemachineのモデルURLを読み込む
  const modelURL = URL + "model.json";
  const metadataURL = URL + "metadata.json";

  // モデルのイメージを格納する
  model = await tmImage.load(modelURL, metadataURL);
  maxPredictions = model.getTotalClasses();

  // 結果を出す為のlavelcontainerをDOMに要素追加する
  labelContainer = document.getElementById("label-container");
  window.requestAnimationFrame(loop);
}

async function loop() {
  // 予測は、画像、ビデオ、またはキャンバスのhtml要素を取り込むことができます
  const prediction = await model.predict(canvas);

  // predictionの数値によって結果を変える
  if (prediction[0].probability.toFixed(2)> 0.1) {
    const base64 = canvas.toDataURL('image/jpeg').replace(/data:.*\/.*;base64,/, '');
    $.ajax({
      url: '/check',
      type: 'POST',
      data: {
          image: base64
        },
      headers: {
          'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
        },
      success: function(data) {
          $(result).append(data);
        }
    })
  } else {
    $(labelContainer).html('失敗')
  }
  $('#shatter').hide();
  $('#reload').show();
}
