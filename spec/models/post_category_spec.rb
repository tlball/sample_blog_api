require 'spec_helper'

describe PostCategory do
  it "cannot be saved without all required info" do
    post_category = PostCategory.new(:category_id=>nil, :post_id=>nil)
    expect(post_category.category_id).to be_nil
    expect(post_category.post_id).to be_nil
    expect(post_category.valid?).to be_false
    expect(post_category.save).to be_false
    expect(post_category.errors).not_to be_empty
  end

  it 'can save with valid info' do
    post_category = PostCategory.new(:category_id=>create(:category).id, :post_id=>create(:post).id)
    expect(post_category.category_id).not_to be_nil
    expect(post_category.post_id).not_to be_nil
    expect(post_category.valid?).to be_true
    expect(post_category.save).to be_true
    expect(post_category.errors).to be_empty
  end
end
