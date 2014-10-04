class PostsController < ApplicationController
  ##
  # Access all posts or all posts by user
  # GET /posts
  # GET /posts.json
  # GET /users/:user_id/posts
  # GET /users/:user_id/posts.json
  def index
    if user_id = params[:user_id]
      @user = User.find(user_id)
      @posts = @user.posts
    else
      @posts = Post.all
    end

    render json: @posts
  end

  ##
  # Display a post for a user
  #
  # GET /users/:user_id/posts/1
  # GET /users/:user_id/posts/1.json
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    render json: @post
  end

  ##
  # Create a post for a user
  #
  # POST /users/:user_id/posts
  # POST /users/:user_id/posts.json
  def create
      @user = User.find(params[:user_id])
      @post = @user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created, location: [@user, @post]
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  ##
  # Update a post for a user
  #
  # PATCH/PUT /users/:user_id/posts/1
  # PATCH/PUT /users/:user_id/posts/1.json
  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  ##
  # Delete a post for a user
  #
  # DELETE /users/:user_id/posts/1
  # DELETE /users/:user_id/posts/1.json
  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy

    head :no_content
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :creator_id, post_categories_attributes: [:category_id])
  end
end
