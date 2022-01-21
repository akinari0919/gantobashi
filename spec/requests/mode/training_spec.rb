require 'rails_helper'

RSpec.describe "ModeTrainings", type: :request do
  describe "GET /mode/training" do
    it "訓練ページにアクセスできること" do
      get "/mode/training"
      expect(response).to have_http_status(:success)
    end

    it "モード選択から訓練ページに遷移できること" do
      visit "/mode/select"
      click_on "ガン飛ばし訓練"
      expect(page).to have_content("訓練開始")
    end
  end

end
