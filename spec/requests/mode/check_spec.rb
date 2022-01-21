require 'rails_helper'

RSpec.describe "ModeChecks", type: :request do
  describe "GET /mode/check" do
    it "診断ページにアクセスできること" do
      get "/mode/check"
      expect(response).to have_http_status(:success)
    end

    it "モード選択から診断ページに遷移できること" do
      visit "/mode/select"
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

end
