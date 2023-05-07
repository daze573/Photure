class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @posts = Post.all
    @genres = Genre.all
  end
end
