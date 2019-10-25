class PostsController < ApplicationController
  def index
    @posts = current_user.posts
  end

  def show
    current_user.posts.find(params[:id])
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
    current_user.posts.find(params[:id])
  end

  def update
    current_user.posts.find(params[:id])
    post.update!(post_params)
    redirect_to posts_url, notice: "投稿「#{post.name}」を更新しました。"
  end

  def destroy
    current_user.posts.find(params[:id])
    post.destroy
    redirect_to posts_url, notice: "投稿「#{post.name}」を削除しました。"  
  end

  private

  def post_params
    params.require(:post).permit(:name, :description)
  end
end
