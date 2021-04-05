class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def index
    @articles = Article.all
  end

  def show
    
  end

  def new
    @article = Article.new
    # @article = current_user.articles.build
  end

  def create
    @article = Article.new(article_params)
    # @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '記事を投稿しました'
    else
      flash.now[:alert] = '記事を投稿出来ませんでした'
      render :new
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新しました'
    else
      flash.now[:alert] = '更新出来ませんでした'
      render :edit
    end
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :eyecatch).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
