require 'spec_helper'

describe Category do
  it 'should be able to add a post' do
    category = Category.where(name: 'work').first
    expect(category.posts).to be_empty
    category.posts << create(:post)
    expect(category.save).to be_true
    expect(category.posts.size).to eq(1)
  end

  it 'should be able to have multiple posts' do
    category = Category.where(name: 'hobbies').first
    expect(category.posts).to be_empty
    3.times do
      category.posts << create(:post)
    end
    expect(category.save).to be_true
    expect(category.posts.size).to eq(3)
  end
end
