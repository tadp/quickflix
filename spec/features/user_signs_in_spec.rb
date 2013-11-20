require 'spec_helper'

feature 'User signs in' do

  scenario "Signing in with valid user email and password" do
    alice = Fabricate(:user)
    visit login_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign in"
    page.should have_content "Welcome"
  end

  scenario "with deactivated user" do
    alice = Fabricate(:user, active: false)
    sign_in(alice)
    expect(page).not_to have_content(alice.full_name)
    expect(page).to have_content("Your account has been suspended, please contact customer service.")
  end
end


