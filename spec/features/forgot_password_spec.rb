require 'spec_helper'

feature 'Password resetter' do
  scenario 'user successfully resets the password' do
    alice = Fabricate(:user, password: 'old_password')

    visit login_path
    click_link "Forgot Password?"
    fill_in("Email Address", with: alice.email)
    click_button "Send Email"

    open_email(alice.email)
    current_email.should have_content 'Please click on the link below to reset your password'

    current_email.click_link('Reset My Password')

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "Email Address", with: alice.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"
    expect(page).to have_content("Welcome")

    clear_email
  end
end