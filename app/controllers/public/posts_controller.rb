class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @tag_list = Tag.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      flash[:alert] = "投稿に失敗しました"
      flash[:errors] = @post.errors.full_messages.join(", ")
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
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :introduction, :genre_id)
  end
end