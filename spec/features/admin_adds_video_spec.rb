require 'spec_helper'

feature 'Admin adds new video' do
  scenario 'Admin successfully adds a new video' do
    admin = Fabricate(:user, password: 'password', admin: true)
    drama = Fabricate(:category, name: 'Drama')
    sign_in(admin)
    visit root_path
    click_link "Admin"

    fill_in("Title", with: "Monk")
    select "Drama", from: "video_categories"
    fill_in "Description", with: "SF detective"
    attach_file "Large cover", "spec/support/uploads/monk_large.jpg"
    attach_file "Small cover", "spec/support/uploads/monk.jpg"
    fill_in "Video URL", with: "http://www.example.com/my_video.mp4"
    click_button "Add Video"

    sign_out
    sign_in

    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='http://www.example.com/my_video.mp4']")

  end
end