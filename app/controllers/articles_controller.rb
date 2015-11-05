class ArticlesController < ApplicationController
  # Calls Devise user authentication before showing 
  # any page except index and show
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]
  before_filter :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = "Your new article was added!"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created."
      render :new
    end
  end

  def show
    @comment = @article.comments.build
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article has been updated"
      redirect_to article_path(@article)
    else
      flash.now[:danger] = "Article has not been updated"
      render :edit
    end  
  end

  def destroy
    @article.destroy
    flash[:success] = "Article has been deleted"
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def set_article
      @article = Article.find(params[:id])     
    end

    def require_same_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user == current_user
      
      flash[:danger] = "You can only edit your own articles."
    end
end
