class ArticlesController < ApplicationController
  # Calls Devise user authentication before showing 
  # any page except index and show
  before_action :authenticate_user!, except: [:index, :show]
  before_filter :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "Your new article was added!"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created."
      render :new
    end
  end

  def show
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
end
