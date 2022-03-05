require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET users/new" do
    it "ユーザー登録ページにアクセスできること" do
      get "/users/new"
      expect(response).to have_http_status(:success)
    end
  end

end
