require 'rails_helper'

RSpec.feature "Adding Reviews to Articles" do
  
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fredd = User.create(email: "fredd@example.com", password: "password")

    @article = Article.create(title: "Test Title", body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", user: @john)
  end

  scenario "permits a signed in user to write a review" do
    login_as(@fredd)

    visit "/"
    click_link @article.title
    fill_in "New Comment", with: "An awesome article"
    click_button "Add Comment"

    expect(page).to have_content("Your comment was added.")
    expect(page).to have_content("An awesome article")
    expect(current_page).to eq(article_path(@article.comments.last.id))
  end
end