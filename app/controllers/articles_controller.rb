class ArticlesController < ApplicationController
  require "article.rb"
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :header_article, only: [:index, :show, :new, :edit, :login_form, :pictures]

  before_action :set_current_user
  before_action :authenticate_user, only: [:new, :edit]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per_page(5)
    @new_articles = Article.order(created_at: :desc).limit(5)
    @user = User.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @articles = Article.order(created_at: :desc).page(params[:page]).limit(5)
    @before_article = Article.where("id < ?", params[:id]).order(id: :desc).first
    @next_article = Article.where("id > ?", params[:id]).order(id: :asc).first
  end


  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  def pictures
    @articles = Article.order(created_at: :desc).page(params[:page]).per_page(9)
  end


  # login

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def header_article
      @first = Article.first
      @last = Article.last
    end

    def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      redirect_to("/")
    end
  end


    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:picture, :title, :text)
    end
end
