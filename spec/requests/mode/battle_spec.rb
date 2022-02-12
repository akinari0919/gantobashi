require 'rails_helper'

RSpec.describe "Mode::Battles", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/mode/battle/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/mode/battle/show"
      expect(response).to have_http_status(:success)
    end
  end

end
