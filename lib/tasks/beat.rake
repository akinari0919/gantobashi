namespace :beat do
  desc "全ての勝利ロックをリセットする"
  task reset_beats: :environment do
    Beat.all.delete_all
  end
end
