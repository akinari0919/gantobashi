require 'rails_helper'

RSpec.describe "ModeSelects", type: :request do
  describe "GET /mode/select" do
    it "モード選択ページにアクセスできること" do
      get "/mode/select"
      expect(response).to have_http_status(:success)
    end

    it "トップページからモード選択ページに遷移できること" do
      visit "/"
      click_on "さっそくガン飛ばす"
      expect(page).to have_content("モード選択")
    end

    it "遊び方ページからモード選択ページに遷移できること" do
      visit "/about"
      click_on "そろそろガン飛ばす"
      expect(page).to have_content("モード選択")
    end
  end

end
