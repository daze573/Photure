class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @posts = Post.all.page(params[:page]).per(16)
    @genres = Genre.all
  end
end
