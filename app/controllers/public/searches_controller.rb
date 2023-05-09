class Public::SearchesController < ApplicationController
  def search
    if params[:title].present?
      @posts = Post.where('title LIKE ?', "%#{params[:title]}%").page(params[:page]).per(16)
    else
      @posts = Post.none
    end
  end
end
