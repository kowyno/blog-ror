class CommentsController < ApplicationController
  before_action :authenticate_user! # debemos autenticar al usuario para comentar
  before_action :set_article, only: [:create]
  before_action :set_comment, except: [:create]

  def create
    @comment = @article.comments.build(parsed_comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article), notice: "¡Comentario agregado exitosamente!"
    else
      redirect_to article_path(@article), alert: "Error al agregar el comentario. Verifica los datos."
    end
  end

  def destroy
    authorize_comment(@comment)

    if @comment.destroy
      redirect_to article_path(@comment.article), notice: "Comentario eliminado exitosamente!", status: :see_other
    else
      redirect_to article_path(@comment.article), alert: "No se pudo eliminar el comentario.", status: :see_other
    end
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def parsed_comment_params
      params.require(:comment).permit(:body)
    end

    def authorize_comment(comment)
      authorize comment
    end
end