class CategoriesController < AuthenticatedController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all.order(:created_at)
    authorize @categories
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit; end

  def create
    @category = Category.new category_params
    authorize @category


    respond_to do |format|
      if @category.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace('categories', partial: 'categories/categories', locals: { categories: Category.all })}
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_category_form', partial: 'categories/form', locals: { category: @category, text_btn: 'Guardar', form_id: 'new_category_form' })}
      end
    end
  end

  def update
    authorize @category

    respond_to do |format|
      if @category.update category_params
        format.turbo_stream { render turbo_stream: turbo_stream.replace("category_#{@category.id}", partial: 'categories/category', locals: { category: @category })}
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('edit_category_form', partial: 'categories/form', locals: { category: @category, text_btn: 'Editar', form_id: 'edit_category_form' })}
      end
    end
  end

  def destroy
    authorize @category

    @category.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('categories', partial: 'categories/categories', locals: { categories: Category.all })}
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
