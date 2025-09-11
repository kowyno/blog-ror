class CommentsController < ApplicationController
  before_action :authenticate_user! # debemos autenticar al usuario para comentar
  before_action :set_article

  def create
    @comment = @article.comments.build(parsed_comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article), notice: "¡Comentario agregado exitosamente!"
    else
      redirect_to article_path(@article), alert: "Error al agregar el comentario. Verifica los datos."
    end
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def parsed_comment_params
      params.require(:comment).permit(:body)
    end
end