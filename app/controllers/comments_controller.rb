class CommentsController < ApplicationController
  before_action :set_article

  def create
    unless current_user
      flash[:danger] = "Please sign in or sign up first."
      redirect_to new_user_session_path
    else
      @comment = @article.comments.build(comments_params)
      @comment.user = current_user

      if @comment.save
        flash[:success] = "Your comment was added." 
      else
        flash.now[:danger] = "Comment was not added, try again."
      end

      redirect_to article_path(@article)
    end
  end

  private
    def comments_params
      params.require(:comment).permit(:body)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end
