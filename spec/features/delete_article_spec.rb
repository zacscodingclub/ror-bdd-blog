require 'rails_helper'

RSpec.feature "Deleting an Article"  do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    login_as(@john)
    @article = Article.create(title: "Test Title", body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", user: @john)
  end

  scenario "A user deletes an article" do
    visit "/"
    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end