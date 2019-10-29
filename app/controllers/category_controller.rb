class CategoryController < ApplicationController
    before_action :find_category, only: [:show]
    before_action :missing_category, only: [:show]

    def index 
        @category = Category.all
    end

    def new
        @category = Category.new
    end

    def create 
        @category = Category.new(category_param)
        if @category.save
            flash[:status] = :success
            flash[:result_text] = "Successfully added a new category"

            redirect_to root_path
        else
            flash[:status] = :failure
            flash[:result_text] = "Failed to add a new category"

            redirect_to root_path
        end
    end

    def show
    end

    private

    def category_param
        return params.require(:category).permit(:name)
    end


    def find_category
        @category = Category.find_by_id(params[:id])
    end

    def missing_category
        if @category.nil?
            flash[:error] = "Could not find the category with the id #{params[:id]}."
            
            redirect_to root_path
        end
    end
end
