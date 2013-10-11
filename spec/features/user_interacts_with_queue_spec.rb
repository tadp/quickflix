require 'spec_helper'

feature 'User interacts with the queue' do
  scenario "user adds and reorders videos in the queue" do
    comedy = Fabricate(:category)
    monk = Fabricate(:video, title: 'Monk', categories:[comedy])
    south_park = Fabricate(:video, title: "South Park", categories:[comedy])
    futurama = Fabricate(:video, title: "Futurama", categories:[comedy])

    sign_in

    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    expect_link_not_to_be_seen("+ My Queue")

    add_video_to_queue(south_park)
    add_video_to_queue(futurama)

    # Mod 6.3 Easiest way with id's. Only works with id, name or labels
    # fill_in "video_#{monk.id}", with: 3
    # fill_in "video_#{south_park.id}", with: 1
    # fill_in "video_#{futurama.id}", with: 2

    # Find using data values
    # find("input[data-video-id='#{monk.id}']").set(3)
    # find("input[data-video-id='#{south_park.id}']").set(1)
    # find("input[data-video-id='#{futurama.id}']").set(2)

    # Find using scoping
    set_video_position(monk, 3)
    set_video_position(south_park, 1)
    set_video_position(futurama, 2)

    update_queue

    # Expectations using data attributes
    # expect(find("input[data-video-id='#{south_park.id}']").value).to eq("1")
    # expect(find("input[data-video-id='#{futurama.id}']").value).to eq("2")
    # expect(find("input[data-video-id='#{monk.id}']").value).to eq("3")

    # Expectations using scoping
    # expect(find(:xpath, "//tr[contains(.,'#{south_park.title}')]//input[@type='text']").value).to eq("1")
    # expect(find(:xpath, "//tr[contains(.,'#{futurama.title}')]//input[@type='text']").value).to eq("2")
    # expect(find(:xpath, "//tr[contains(.,'#{monk.title}')]//input[@type='text']").value).to eq("3")

    #Stay on the same abstraction level. Extracting to methods here is good here since it is a feature spec.
    expect_video_position(south_park, 1)
    expect_video_position(futurama, 2)
    expect_video_position(monk, 3)


  end

  def expect_video_to_be_in_queue(video)
    page.should have_content(video.title)
  end

  def expect_link_not_to_be_seen(link_text)
    page.should_not have_content(link_text)
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][list_order]", with: position.to_s
    end
  end

  def update_queue
    click_button "Update Instant Queue"    
  end

end