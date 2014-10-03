class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    if user_id = params[:user_id]
      @user = User.find(user_id)
      @posts = @user.posts
    else
      @posts = Post.all
    end


    render json: @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    render json: @post
  end

  # POST /posts
  # POST /posts.json
  def create
      @user = User.find(params[:user_id])
      @post = @user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created, location: [@user, @post]
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
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
