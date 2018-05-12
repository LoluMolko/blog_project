require 'pry'
class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :update, :edit, :destroy]

  def index
    @articles = Article.all
    @articles = Article.where("? = any(tags)", params[:q].downcase) if params[:q].present?

    #binding.pry
    #tutaj przeiterowujemy sie przez wszystko co zawiera sie w Article.all
    #if params[:q].present?
      #@articles = Article.all.select do |article|
      #  article.tags.include?(params[:q])
    #  end
    #else
      #@articles = Article.all
    #end
  end

  def new
    @article = Article.new
  end

  def create
    article_params
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Your article has been saved"
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
      flash[:notice] = "Your article has been updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Your article has been deleted"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :tags, :text)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
