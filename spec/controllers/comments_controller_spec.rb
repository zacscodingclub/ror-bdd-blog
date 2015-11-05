require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do 
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

    context "signed in user" do
      it "can create a comment" do
        login_user(@john)
        
        post :create, comment: {body: "Awesome post"}, article_id: @article.id

        expect(flash[:success]).to eq("Your comment was added.")
      end
    end

    context "non-signed in user" do
      it "is redirected to the sign in page" do
        login_user(nil)

        post :create, comment: {body: "Awesome post"}, article_id: @article.id

        expect(response).to redirect_to new_user_session_path
      end
    end
  end  
end
