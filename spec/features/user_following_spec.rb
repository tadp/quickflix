require 'spec_helper'

feature 'User following' do
  scenario 'user follows and unfollows someone' do
    comedy = Fabricate(:category)
    monk = Fabricate(:video, title: 'Monk', categories:[comedy])
    bob = Fabricate(:user)
    review = Fabricate(:review, video: monk, user: bob)

    sign_in
    click_video_on_home_page(monk)
    page.should have_content(monk.title)

    click_link bob.full_name
    page.should have_content("video collections")

    click_link "Follow"
    page.should have_content(bob.full_name)

    # find("a[href='/relationships/#{bob.id}']").click
    unfollow(bob)
    page.should_not have_content(bob.full_name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end