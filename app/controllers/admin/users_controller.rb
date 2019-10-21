class Admin::UsersController < ApplicationController
  def index
    @user = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(user_params)

    if @user.save
        redirect_to admin_users_path, notice: "ユーザー「＃{@user.name}」を登録しました。"
    else
      reder :new
    end

    def update
      @usern = User.find(params[:id])
      
      if @user.update(user_params)
        redirect_to admin_users_url, notice: "ユーザー「＃{@user.name}」を更新しました。"
      else
        reder :new
      end
    end

    def destroy
      @user = User.find(params)
      @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「＃{@user.name}」を登録しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end
