class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    render :index
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    render :index
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
