class CategoriesController < ApplicationController

  ##
  # Lists all categories
  #
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all

    render json: @categories
  end

  ##
  # Displays a category
  #
  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    render json: @category
  end

  ##
  # Creates a category
  #
  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  ##
  # Updates a category
  #
  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      head :no_content
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  ##
  # Deletes a category
  #
  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    head :no_content
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
