require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  context "authorized access" do
    before :each do
      stub_sign_in
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    it "allows authenticated access" do
      stub_sign_in
      get :index
      expect(response).to be_success
    end
  end

  it "blocks unauthenticated access" do
    get :index
    expect(response).to redirect_to(new_user_session_path)
  end
end
