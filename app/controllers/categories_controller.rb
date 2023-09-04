class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all.order(:created_at)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new category_params

    respond_to do |format|
      if @category.save
        format.turbo_stream { render turbo_stream: turbo_stream.append('categories', partial: 'categories/category', locals: { category: @category }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('category_form', partial: 'categories/form', locals: { category: @category, text_btn: 'Guardar' })}
      end
    end
  end

  def update
    debugger
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("category_#{@category.id}") }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
