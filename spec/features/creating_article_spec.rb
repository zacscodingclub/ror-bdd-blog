require 'rails_helper'

RSpec.feature "Creating Articles" do
  scenario "A user creates a new article" do
    # Modeled actions
    visit "/"  # Go to root
    click_link "New Article"
    fill_in "Title", with: "Creating first article"
    fill_in "Body", with: "Lorem ipsum"
    click_button "Create Article"

    # Test expectations
    expect(page).to have_content("Your new article was added!")
    expect(page.current_path).to eq(articles_path)
  end

  scenario "A user fails to create a new article" do
    # Modeled actions
    visit "/"
    click_link "New Article"
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Create Article"

    # Test expectations
    expect(page).to have_content("Article has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end