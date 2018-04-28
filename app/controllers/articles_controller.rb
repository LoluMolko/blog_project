class ArticlesController < ApplicationController
  def index
  end

  def new
  end

  def create
    articles_params = params.require(:article).permit(:title, :text)
    @article = Article.new(articles_params)
    @article.save

    redirect_to articles_path
  end

end
