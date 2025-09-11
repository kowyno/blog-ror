class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :destroy, :update]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(parse_article_params)
    if @article.save
      redirect_to @article, notice: "¡Artículo creado exitosamente!"
    else
      flash.now[:error] = "Error al crear el artículo. Verifica los datos ingresados."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(parse_article_params) then
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def parse_article_params
      params.require(:article).permit(:title, :body)
    end
end
