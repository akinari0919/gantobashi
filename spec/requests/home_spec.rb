require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /" do
    it "トップページにアクセスできること" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "遊び方ページにアクセスできること" do
      get "/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /service" do
    it "利用規約ページにアクセスできること" do
      get "/service"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /privacy" do
    it "プライバシーポリシーページにアクセスできること" do
      get "/privacy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /info" do
    it "お問合せページにアクセスできること" do
      get "/info"
      expect(response).to have_http_status(:success)
    end
  end

end
