class GoodsController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post][:post_id])
    current_user.good(@post)
    @post.create_notification_good!(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    current_user.ungood(@post)

  end

end
