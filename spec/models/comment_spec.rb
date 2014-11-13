require 'rails_helper'

RSpec.describe Comment, :type => :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:comment)).to be_valid
  end

  it 'is invalid without an author' do
    expect(FactoryGirl.build(:comment, author: nil)).to_not be_valid
  end

  it 'is invalid without a text' do
    expect(FactoryGirl.build(:comment, text: nil)).to_not be_valid
  end

  it 'is invalid without an 0 character text' do
    expect(FactoryGirl.build(:comment, text: '')).to_not be_valid
  end

end
