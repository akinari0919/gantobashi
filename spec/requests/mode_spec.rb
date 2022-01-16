require 'rails_helper'

RSpec.describe "Modes", type: :request do
  describe "GET /mode/index" do
    it "モード一覧ページにアクセスできること" do
      get "/mode/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /mode/check" do
    it "診断ページにアクセスできること" do
      get "/mode/check"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /mode/check/show" do
    it "診断結果の詳細ページに直接アクセスできないこと" do
      get "/mode/check/show"
      expect(response.status).to eq 302
    end
  end

  describe "GET /mode/training" do
    it "訓練ページにアクセスできること" do
      get "/mode/training"
      expect(response).to have_http_status(:success)
    end
  end

end
