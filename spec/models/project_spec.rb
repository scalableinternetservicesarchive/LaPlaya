require 'rails_helper'

RSpec.describe Project, :type => :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:project)).to be_valid
  end

  it 'is invalid without a thumbnail' do
    expect(FactoryGirl.build(:project, thumbnail: nil)).to_not be_valid
  end

  it 'is invalid without a title' do
    expect(FactoryGirl.build(:project, title: nil)).to_not be_valid
  end

  it 'is invalid without a title and a thumbnail' do
    expect(FactoryGirl.build(:project, title: nil, thumbnail: nil)).to_not be_valid
  end

  it 'is invalid without an author' do
    expect(FactoryGirl.build(:project, author: nil)).to_not be_valid
  end

  it 'is invalid without an 4 character title' do
    expect(FactoryGirl.build(:project, title: 'cats')).to_not be_valid
  end

  it 'is invalid without an 0 character title' do
    expect(FactoryGirl.build(:project, title: '')).to_not be_valid
  end

  it { should respond_to(:likes) }

end
