class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    articles_params = params.require(:article).permit(:title, :text)
    @article = Article.new(articles_params)
    if @article.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    articles_params = params.require(:article).permit(:title, :text)
    if @article.update(articles_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
end
