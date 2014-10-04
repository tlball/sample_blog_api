class UsersController < ApplicationController
  ##
  # Lists all users
  #
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  ##
  # Shows a user
  #
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render json: @user
  end

  ##
  # Creates a user
  #
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  ##
  # Updates a user
  #
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  ##
  # Deletes a user
  #
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
