class Public::InformationController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_guest_user, except: [:show, :edit]

  def show
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(16)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_information_path
    else
      flash[:alert] = "更新できませんでした"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def ensure_guest_user
    @user = User.find(params[:user_id])
    if @user.name == "ゲストログイン"
      redirect_to root_path
    end
  end
end
