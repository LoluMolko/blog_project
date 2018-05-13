class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show update edit destroy]
  before_action :authorize_article, only: %i[edit update destroy]

  def index
    @articles = Article.page(params[:page]).per(3)
    @articles = @articles.where('? = any(tags)', params[:q].downcase) if params[:q].present?

    # przeiterowujemy sie przez wszystko w articles
    # if params[:q].present?
    # @articles = Article.all.select do |article|
    # article.tags.include?(params[:q])
    # end
    # else
    # @articles = Article.all
    # end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permitted_attributes(Article))
    # permitted_attributes zawsze wymaga argumentu
    @article.author = current_user
    if @article.save
      flash[:notice] = 'Your article has been saved'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = @article.comments.build(commenter: session[:commenter])
    @like = Like.find_or_initialize_by(article: @article, user: current_user)
  end

  def edit; end

  def update
    if @article.update(permitted_attributes(@article))
      flash[:notice] = 'Your article has been updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = 'Your article has been deleted'
    redirect_to articles_path
  end

  private

  # def article_params
  #  params.require(:article).permit(:title, :tags, :text, :likes)
  # end

  def find_article
    @article = Article.find(params[:id])
  end

  def authorize_article
    authorize @article
      # if @article.author != current_user
      #  flash[:alert] = 'This is not your article'
      #  redirect_to articles_path
      #end
  end
end
