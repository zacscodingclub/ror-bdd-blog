require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
    include Devise::TestHelpers
    
    before do
      @john = User.create(email: "john@example.com", password: "password")
      @article = Article.create( title: "Test Title",
                                  body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                                        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                                        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                                        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                  user: @john)
    end

    context "owner is allowed to edit his articles" do
      it "renders the edit template" do 
        login_user(@john)

        get :edit, id: @article
        expect(response).to render_template :edit
      end
    end

    context "non-owner is not allowed to edit other users' articles" do
      it "redirects to root path" do
        @fredd = User.create(email: "fredd@example.com", password: "password")

        login_user(@fredd)
        get :edit, id: @article
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own articles."
        expect(flash[:danger]).to eq message
      end
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
