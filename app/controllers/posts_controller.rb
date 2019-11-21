class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :login_required

  def index
    @q = current_user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page])
    #@posts = current_user.posts.order(created_at: :desc)
  end

  def show

  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: "投稿「#{@post.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    @post.update!(post_params)
    redirect_to posts_url, notice: "投稿「#{post.name}」を更新しました。"
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "投稿「#{post.name}」を削除しました。"  
  end

  private

  def post_params
    params.require(:post).permit(:name, :description, :image)
  end
  
  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def login_required
    redirect_to login_path unless current_user
  end
end
