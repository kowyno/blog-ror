class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(parse_article_params)
    if @article.save
      redirect_to @article, notice: "¡Artículo creado exitosamente!"
    else
      flash.now[:error] = "Error al crear el artículo. Verifica los datos ingresados."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(parse_article_params) then
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private

    def parse_article_params
      params.require(:article).permit(:title, :body)
    end
end
