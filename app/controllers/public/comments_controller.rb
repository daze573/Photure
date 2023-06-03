class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if user_signed_in? && current_user.id == @comment.user_id
      @comment.destroy
    else
      admin_signed_in?
      @comment.destroy
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end
end
