require 'rails_helper'

RSpec.describe "Modes", type: :request do
  describe "GET /mode/index" do
    it "モード一覧ページにアクセスできること" do
      get "/mode/index"
      expect(response).to have_http_status(:success)
    end

    it "トップページからモード一覧ページに遷移できること" do
      visit "/"
      click_on "さっそくガン飛ばす"
      expect(page).to have_content("モード選択")
    end
  end

  describe "GET /mode/check" do
    it "診断ページにアクセスできること" do
      get "/mode/check"
      expect(response).to have_http_status(:success)
    end

    it "モード一覧から診断ページに遷移できること" do
      visit "/mode/index"
      click_on "ガン飛ばし診断"
      expect(page).to have_content("ガン飛ばす")
    end
  end

  describe "GET /mode/check/show" do
    it "診断結果の詳細ページに直接アクセスできないこと" do
      get "/mode/check/show"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /mode/training" do
    it "訓練ページにアクセスできること" do
      get "/mode/training"
      expect(response).to have_http_status(:success)
    end

    it "モード一覧から訓練ページに遷移できること" do
      visit "/mode/index"
      click_on "ガン飛ばし訓練"
      expect(page).to have_content("訓練開始")
    end
  end

end
