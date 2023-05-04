class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @tag_list = Tag.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end


  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :introduction, :genre_id)
  end
end
