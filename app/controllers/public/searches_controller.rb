class Public::SearchesController < ApplicationController
  def search
    if params[:title].present?
      @posts = Post.where('title LIKE ?', "%#{params[:title]}%")
    else
      @posts = Post.none
    end
  end
end
