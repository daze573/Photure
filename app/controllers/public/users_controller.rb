class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def show
  end

  def edit
  end

  def withdraw
  end

  def resign
    @user = current_user
    @user.update(user_status: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストログイン"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
