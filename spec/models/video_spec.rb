require 'spec_helper'
require 'pry'

describe Video do
  #Same validation as below using shoulda matchers
  it { should have_many(:categories)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  it "search by exact title" do
    family_guy= Video.create(title: "family", description: "A great video!")
    expect(Video.search_by_title("family")).to eq([family_guy])
  end

  it "search by semi title" do
    family_guy= Video.create(title: "family guy", description: "A great video!")
    expect(Video.search_by_title("family")).to eq([family_guy])
  end


############ Doesn't work yet
  it "return six most recent videos" do
    comedy = Category.create([{name: 'Comedy'}])
    how_i_met_your_mother = Video.create([{title: 'How I Met Your Mother', description: "Cool show", category: comedy}]) 
    friends = Video.create([{title: 'Friends', description: "Cool show", category: comedy}]) 
    simpsons = Video.create([{title: 'Simpsons', description: "Cool show", category: comedy}]) 
    south_park = Video.create([{title: 'Southpark', description: "Cool show", category: comedy}]) 
    futurama = Video.create([{title: 'Futurama', description: "Cool show", category: comedy}]) 
    family_guy = Video.create([{title: 'Family Guy', description: "Cool show", category: comedy}]) 
    monk = Video.create([{title: 'Monk', description: "Cool show", category: comedy}]) 
    expect(comedy.recent_videos).to eq([monk,family_guy, futurama, south_park, simpsons, friends])
  end

  #First attempt
  # it 'saves a video' do
  #   video= Video.new(title:'First_title', description:'A great description')
  #   video.save.should_not == false
  # end
  #Another example with 'expect' syntax
  # it 'saves a video' do
  #   video= Video.new(title:'First_title', description:'A great description')
  #   video.save
  #   expect(Video.first).to eq(video)
  # end


  #Inefficient validation test:
  # it 'complains without a video title' do
  #   video=Video.new(description:'A great description')
  #   video.save.should == false
  # end

  # it 'complains without a video description' do
  #   video=Video.new(title:'First_title')
  #   video.save.should == false
  # end
  #Another example
    # it "does not save a video without a title" do
    #   video= Video.create(description: "a great video!")
    #   expect(Video.count).to eq(0)
    # end

    #Ugly association tests
  # it 'associate with categories' do
  #   category=Category.create(name:'Action')
  #   video= Video.create(title:'First_title', description:'A great description')
  #   category.videos << video
  #   video.categories.should_not be_nil
  # end

  # it 'belongs to category' do
  #   dramas = Category.create(name:"dramas")
  #   monk= Video.create(title: "Monk", description: "A great video!")
  #   monk.categories << [dramas]
  #   expect(monk.categories).to eq([dramas])
  # end


end
