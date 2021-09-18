class GoodsController < ApplicationController

  def create
    @post = Post.find(params[:post][:post_id])
    current_user.good(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    current_user.ungood(@post)

  end

end
