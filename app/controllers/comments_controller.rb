class CommentsController < ApplicationController

  before_action :authenticate_user!


  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    @post.create_notification_comment!(current_user, @comment.id)
    @comments = @post.comments.order(created_at: :desc)
    render :index
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      Comment.find_by(id: params[:id]).destroy
      redirect_to post_path(@post)
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
