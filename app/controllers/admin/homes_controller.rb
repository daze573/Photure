class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @user = current_user
    @posts = Post.all
    @genres = Genre.all
  end
end
