class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

    if @comment.save
      session[:commenter] = @comment.commenter
      flash[:notice] = 'Your comment has been saved'
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = 'Your comment has been deleted'
    redirect_to article_path(@comment.article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
