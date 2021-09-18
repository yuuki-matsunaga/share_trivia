class GoodsController < ApplicationController

  def create
    @post = Post.find(params[:post][:post_id])
    current_user.good(@post)
    # binding.pry
  end

  def destroy
    # binding.pry
    @post = Post.find(params[:id])
    current_user.ungood(@post)
 
  end

end
