class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @user = current_user
    @posts = Post.all.page(params[:page]).per(12)
    @genres = Genre.all
  end
end
