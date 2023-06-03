class Public::PostsController < ApplicationController
  before_action :authenticate!
  def new
    @post = Post.new
    @post.post_images.build
    @tag_list = []
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag].split('　')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to root_path
    else
      flash[:alert] = "投稿に失敗しました"
      @tag_list = tag_list
      render :new, locals: { tag_list: tag_list }
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
    @tag_list = @post.tags.pluck(:name).join('　')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag].split('　')
    if @post.update(post_params)
      @old_relations = PostTag.where(post_id: @post.id)
        @old_relations.each do |relation|
          relation.delete
        end
      @post.save_tag(tag_list)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def genre_search
    @genre = Genre.find(params[:post_id])
    @posts = @genre.posts.all.page(params[:page]).per(12)
    @genres = Genre.all
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all.page(params[:page]).per(12)
  end

  def qrcode
    @post = Post.find(params[:post_id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :introduction, :genre_id, post_images_images: [])
  end

  def authenticate!
    if admin_signed_in?
      authenticate_admin!
    else
      authenticate_user!
    end
  end
end
