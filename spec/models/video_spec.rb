require 'spec_helper'
require 'pry'

describe Video do
  #Same validation as below using shoulda matchers
  it { should have_many(:categories)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("hello")).to eq([])
    end

    it "returns an array of one video for an exact match" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("Futurama")).to eq([futurama])
    end

    it "returns an array of all matches ordered by created_at" do 
      futurama = Video.create(title: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("Futur")).to eq([back_to_future, futurama])
    end

    it "searches by semi title" do
        family_guy= Video.create(title: "family guy", description: "A great video!")
        expect(Video.search_by_title("family")).to eq([family_guy])
    end
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
