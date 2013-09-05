require 'spec_helper'
require 'pry'

describe Video do
  #Same validation as below using shoulda matchers
  it { should have_many(:categories)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

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
