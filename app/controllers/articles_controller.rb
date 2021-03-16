class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '記事を投稿しました'
    else
      flash.now[:alert] = '記事を投稿出来ませんでした'
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新しました'
    else
      flash.now[:alert] = '更新出来ませんでした'
      render :edit
    end
  end

  # def destroy
  #   article = Article.find(params[:id])
  #   article.destroy!
  #   redirect_to root_path, notice: '記事を削除しました'
  # end

  def destroy
    article = Article.find(params[:id])
    article.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
