namespace :beat do
  desc "全ての勝利ロックをリセットする"
  task reset_beats: :environment do
    @glaring_face_photos = GlaringFacePhoto.all
    @glaring_face_photos.each do |gfp|
      @beats = gfp.beats.all
      @beats.each do |beat|
        beat.destroy
      end
    end
  end
end
