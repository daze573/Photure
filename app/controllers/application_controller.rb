class ApplicationController < ActionController::Base
  before_action :set_post

  private

  def set_post
    @post = Post.find_by(params[:id])
    redirect_to root_path, notice: "Post not found" unless @post
  end
end
