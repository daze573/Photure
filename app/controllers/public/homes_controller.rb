class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @posts = Post.order(created_at: :desc).page(params[:page]).per(12)
    @genres = Genre.all
  end
end
