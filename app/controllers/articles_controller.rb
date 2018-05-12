class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :update, :edit, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    article_params
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = @article.comments.build(commenter: session[:commenter])
  end

  def edit
  end

  def update
    article_params
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def find_article
    @article = Article.find(params[:id])
  end

end
