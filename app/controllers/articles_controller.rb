class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
  end

  def create
    articles_params = params.require(:article).permit(:title, :text)
    @article = Article.new(articles_params)
    @article.save

    redirect_to article_path(@article)
  end

  def show
    @article = Article.find(params[:id])
  end

end
