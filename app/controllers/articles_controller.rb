class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :destroy, :update, :publish, :unpublish]
  before_action :authorize_article, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def index
    @articles = policy_scope(Article)
  end

  def show
  end

  def new
    authorize Article
    @article = current_user.articles.build
  end

  def create
    authorize Article
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
      redirect_to @article, notice: "¡Artículo actualizado exitosamente!"
    else
      flash.now[:error] = "Error al actualizar el artículo. Verifica los datos ingresados."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, notice: "¡Artículo eliminado exitosamente!", status: :see_other
    else
      redirect_to articles_path, alert: "No se pudo eliminar el artículo.", status: :see_other
    end
  end

  def publish
    @article.published!
    redirect_to @article, notice: "¡Artículo publicado exitosamente!", status: :see_other
  end

  def unpublish
    @article.draft!
    redirect_to @article, notice: "¡Artículo despublicado exitosamente!", status: :see_other
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def parse_article_params
      params.require(:article).permit(:title, :body)
    end

    def authorize_article
      authorize @article
    end
end
