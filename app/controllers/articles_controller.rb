class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show update edit destroy likes_summary]
  before_action :authorize_article, only: %i[edit update destroy]

  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result.includes(:author).page(params[:page])
    @most_commented_article = Article.most_commented.first

    # @articles = @q.resultArticle.includes(:author).order(created_at: :desc).page(params[:page]).per(5).order("id desc")
    # @articles = @articles.where('? = any(tags)', params[:q].downcase) if params[:q].present?

    # przeiterowujemy sie przez wszystko w articles
    # if params[:q].present?
    # @articles = Article.all.select do |article|
    # article.tags.include?(params[:q])
    # end
    # else
    # @articles = Article.all
    # end
    @most_commented_article = Article.most_commented.first
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

    respond_to do |format|
      format.html do
        @article.increment!(:views_count)
        render
      end
      format.json do
        render json: {
          id: @article.id,
          likes: @article.likes_count,
          comments: @article.comments_count
        }
      end
    end
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

  def likes_summary
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
