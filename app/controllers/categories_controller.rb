class CategoriesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user_id
	before_action :set_category, only: %i[show edit update destroy]

	# GET /categories or /categories.json
	def index
		@categories = Category.where(user_id: @user_id)
	end

	# GET /categories/1 or /categories/1.json
	def show; end

	# GET /categories/new
	def new
		@category = Category.new
	end

	# GET /categories/1/edit
	def edit; end

	# POST /categories or /categories.json
	def create
		@category = Category.new(category_params)

		if @category.save
			redirect_to categories_path, notice: 'Category was successfully created.'
		else
			render :new
		end
	end

	# PATCH/PUT /categories/1 or /categories/1.json
	def update
		if @category.update(category_params)
			redirect_to @category, notice: 'Category was successfully updated.'
		else
			render :edit
		end
	end

	# DELETE /categories/1 or /categories/1.json
	def destroy
		@category.destroy
		redirect_to categories_url, notice: 'Category was successfully destroyed.'
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_user_id
		@user_id = current_user.id
	end

	def set_category
		@category = Category.find(params[:id])
	end

	# Only allow a list of trusted parameters through.
	def category_params
		params.require(:category).permit(:name).merge(user_id: @user_id)
	end
end
