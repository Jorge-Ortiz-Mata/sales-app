class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy add_categories save_categories]

  def index
    @articles = Article.all.order(:created_at)
    @filter_form = FilterForm.new
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: 'El articulo ha sido creado exitosamente' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: 'El articulo ha sido actualizado exitosamente' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'El articulo ha sido eliminado exitosamente.' }
    end
  end

  def add_categories; end

  def save_categories
    @article.categories.clear

    category_ids.each do |id|
      @article.categories << Category.find(id)
    end

    redirect_to article_path(@article), notice: 'Las categorias han sido actualizadas correctamente'
  end

  def search_by_name
    return unless params[:name].present?

    article = Article.find_by(name: params[:name])

    respond_to do |format|
      if article
        format.turbo_stream { render turbo_stream: turbo_stream.replace('articles', partial: 'articles/articles', locals: { articles: [article], filter_form: FilterForm.new }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('articles', partial: 'articles/articles', locals: { articles: [], filter_form: FilterForm.new }) }
      end
    end
  end

  def filter
    single_filter if params[:attribute].present?
    filter_with_form if params[:filter_form].present?
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :description, :price, :avatar, :promotional_video, images: [])
  end

  def filter_form_params
    params.require(:filter_form).permit(:category, :min_price, :max_price)
  end

  def category_ids
    params[:categories][:ids].reject { |c| c.empty? }
  end

  def single_filter
    articles = Article.all.order(params[:attribute])
    @filter_form = FilterForm.new

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('articles', partial: 'articles/articles', locals: { articles: articles, filter_form: FilterForm.new }) }
    end
  end

  def filter_with_form
    filter_form = FilterForm.new(filter_form_params)

    respond_to do |format|
      if filter_form.save
        articles = filter_form.search_process

        format.turbo_stream { render turbo_stream: turbo_stream.replace('articles', partial: 'articles/articles', locals: { articles: articles, filter_form: filter_form }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('filter_form', partial: 'articles/filter_form', locals: { filter_form: filter_form }) }
      end
    end
  end
end
