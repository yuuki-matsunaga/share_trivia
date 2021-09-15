class GoodsController < ApplicationController

  def create
    @post = Post.find(params[:post])
    current_user.good(@post)
  end

  def destroy
    @post = Like.find(params[:id]).post
    current_user.ungood(@post)
  end

end
