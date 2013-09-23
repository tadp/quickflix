require 'spec_helper'
require 'pry'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }
  
  # it 'associate with videos' do
  #   category=Category.create(name:'Action')
  #   video= Video.create(title:'First_title', description:'A great description')
  #   category.videos << video
  #   category.videos.should_not be_nil
  # end

  # it 'has many videos' do
  #   comedies = Category.create(name:'Comedies')
  #   south_park = Video.create(title: 'South Park', description: "Funny video!")
  #   futurama = Video.create(title:'Futurama', description: "Space travel!")
  #   south_park.categories << comedies
  #   futurama.categories << comedies
  #   expect(comedies.videos).to eq([futurama,south_park])
  #  end
end