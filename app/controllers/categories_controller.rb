class CategoriesController < ApplicationController
    def index

    end
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)

        if @category.save
            redirect_to @category
        else
            render :new, status: :unprocessable_entity
        end
    end
    private
    def category_params
        params.require(:Category).permit(:item)
    end
end
