class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @tag_list = Tag.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
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
    @user = @post.user
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def genre_search
    @genre = Genre.find(params[:id])
    @items = @genre.items.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :introduction, :genre_id)
  end
end
