require 'spec_helper'

describe Post do

  it 'should not be save without a creator' do
    post = build(:post, creator: nil)
    expect(post.creator).to be_nil
    expect(post.valid?).to be_false
    expect(post.save).to be_false
  end

  it 'should not be save if valid' do
    post = build(:post)
    expect(post.creator).not_to be_nil
    expect(post.valid?).to be_true
    expect(post.save).to be_true
  end

  it 'should be able to add a category' do
    post = create(:post)
    expect(post.categories).to be_empty
    post.categories << Category.create(name: 'family')
    post.save
    post.reload
    expect(post.categories.size).to eq(1)
  end

  it 'should be able to have multiple categories' do
    post = create(:post)
    expect(post.categories).to be_empty
    post.categories << Category.create(name: 'family')
    post.categories << Category.create(name: 'home')
    post.save
    expect(post.categories.size).to eq(2)
  end

end
