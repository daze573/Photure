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

  def favorites
    @user = User.find(params[:id])
    # ユーザーidが、このユーザーの、いいねのレコードを全て取得する。そして、そのpost_idも一緒に持ってきてそれをfavoritesに代入。
    # Product.pluck(:name)という記述があった場合、productモデルのnameカラムの一覧を持ってこれる。1つのモデルで使用されているテーブルからカラム (1つでも複数でも可) を取得することができるそう。
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストログイン"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
