class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to user_information_path(current_user)
  end

  def show
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :introduction)
  end
end
