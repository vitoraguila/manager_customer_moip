require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #Pages" do
    it "returns http success" do
      get :Pages
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

end
