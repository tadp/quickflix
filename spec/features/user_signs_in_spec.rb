require 'spec_helper'

feature 'User signs in' do

  scenario "Signing in with valid user email and password" do
    alice = Fabricate(:user)
    visit login_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign in"
    page.should have_content alice.full_name.split.map(&:capitalize).join(' ')
  end
end


