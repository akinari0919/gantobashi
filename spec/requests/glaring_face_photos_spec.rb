require 'rails_helper'

RSpec.describe "GlaringFacePhotos", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/glaring_face_photos/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/glaring_face_photos/index"
      expect(response).to have_http_status(:success)
    end
  end

end
