require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PostsController do

  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:user) {create(:user)}
  let(:user2) {create(:user, first_name:'Barney', last_name:'Rubble')}
  let(:valid_attributes) { { "content" => "My Text",  "title" => "My Post", "creator_id" => user.id} }


  describe "GET index" do
    it "assigns all posts as @posts for user" do
      post = Post.create! valid_attributes
      post2 = Post.create! valid_attributes.merge({creator_id: user2.id})
      get :index, {user_id: user.id}
      assigns(:posts).should eq([post])
      assigns(:posts).should_not include(post2)
    end

    it "assigns all posts as @posts with no user" do
      post1 = Post.create! valid_attributes
      post2 = Post.create! valid_attributes.merge({creator_id: user2.id})
      get :index, {}
      assigns(:posts).should eq([post1, post2])
    end

    it "returns all posts as a JSON object" do
      post1 = Post.create! valid_attributes
      post2 = Post.create! valid_attributes.merge({creator_id: user2.id})
      get :index, {}

      posts = JSON.parse(response.body)
      expect(posts.size).to eq(2)
      expect(posts[0]['id']).to eq(post1.id)
      expect(posts[1]['id']).to eq(post2.id)
      expect(posts[0]['title']).to eq(post1.title)
      expect(posts[1]['title']).to eq(post2.title)
      expect(posts[0]['content']).to eq(post1.content)
      expect(posts[1]['content']).to eq(post2.content)
      expect(posts[0]['creator_id']).to eq(user.id)
      expect(posts[1]['creator_id']).to eq(user2.id)
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      post = Post.create! valid_attributes
      get :show, {id: post.to_param, user_id: user.id}
      assigns(:post).should eq(post)
    end

    it "assigns the requested user as @user" do
      post = Post.create! valid_attributes
      get :show, {id: post.to_param, user_id: user.id}
      assigns(:user).should eq(user)
    end

    it "should return the post as JSON" do
      post = Post.create! valid_attributes
      get :show, {id: post.to_param, user_id: user.id}

      obj = JSON.parse(response.body)
      expect(obj['id']).to eq(user.posts.last.id)
      expect(obj['title']).to eq(user.posts.last.title)
      expect(obj['content']).to eq(user.posts.last.content)
      expect(obj['creator_id']).to eq(user.id)
    end
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, {post: valid_attributes, user_id: user.id}
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, {post: valid_attributes, user_id: user.id}
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end

      it "renders to the created post as JSON" do
        post :create, {post: valid_attributes, user_id: user.id}
        obj = JSON.parse(response.body)
        expect(obj['id']).to eq(user.posts.last.id)
        expect(obj['title']).to eq(user.posts.last.title)
        expect(obj['content']).to eq(user.posts.last.content)
        expect(obj['creator_id']).to eq(user.id)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, {post: { "content" => "invalid value" }, user_id: user.id}
        assigns(:post).should be_a_new(Post)
      end

      it 'returns unprocessable_entity code' do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, {post: { "content" => "invalid value" }, user_id: user.id}
        expect(response.status).to eq(422)
      end

    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested post" do
        post = Post.create! valid_attributes
        # Assuming there are no other posts in the database, this
        # specifies that the Post created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Post.any_instance.should_receive(:update).with({ "content" => "MyText" })
        put :update, {id: post.to_param, post: { "content" => "MyText" }, user_id: user.id}
      end

      it "assigns the requested post as @post" do
        post = Post.create! valid_attributes
        put :update, {id: post.to_param, post: valid_attributes, user_id: user.id}
        assigns(:post).should eq(post)
      end

    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        post = Post.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, {id: post.to_param, post: { "content" => "invalid value" }, user_id: user.id}
        assigns(:post).should eq(post)
      end

      it "returns unprocessable_entity code" do
        post = Post.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, {id: post.to_param, post: { "content" => "invalid value" }, user_id: user.id}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, {id: post.to_param, user_id: user.id}
      }.to change(Post, :count).by(-1)
    end

    it "returns no content" do
      post = Post.create! valid_attributes
      delete :destroy, {id: post.to_param, user_id: user.id}
      expect(response.status).to eq(204)
    end
  end

end
