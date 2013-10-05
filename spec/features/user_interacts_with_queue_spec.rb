require 'spec_helper'

feature 'User interacts with the queue' do
  scenario "user adds and reorders videos in the queue" do
    comedy = Fabricate(:category)
    monk = Fabricate(:video, title: 'Monk')
    monk.categories << comedy
    south_park = Fabricate(:video, title: "South Park")
    south_park.categories << comedy
    futurama = Fabricate(:video, title: "Futurama")
    futurama.categories << comedy
    sign_in


    find("a[href='/video/#{monk.id}']").click
    page.should have_content(monk.title)
  end
end