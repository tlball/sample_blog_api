require 'spec_helper'

describe User do
  it "cannot be saved without all required info" do
    user = build(:user, first_name: nil, last_name: nil)
    expect(user.first_name).to be_nil
    expect(user.last_name).to be_nil
    expect(user.email).not_to be_nil
    expect(user.valid?).to be_false
    expect(user.save).to be_false
    expect(user.errors).not_to be_empty
  end

  it 'can save with valid info' do
    user = build(:user)
    expect(user.first_name).not_to be_nil
    expect(user.last_name).not_to be_nil
    expect(user.email).not_to be_nil
    expect(user.valid?).to be_true
    expect(user.save).to be_true
    expect(user.errors).to be_empty
  end

  it 'should be able to create a post' do
    user = create(:user)
    expect(user.posts).to be_empty
    user.posts.build(title: 'Fred gets fired', content: 'Today Fred went to work and made Mr. Slate mad, so he got fired.')
    user.save!
    expect(user.posts.size).to eq(1)
  end
end
