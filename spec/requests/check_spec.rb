require 'rails_helper'

RSpec.describe "Tests", type: :request do
  describe "GET /result" do
    it "returns http success" do
      get "/check/result"
      expect(response).to have_http_status(:success)
    end
  end

end
