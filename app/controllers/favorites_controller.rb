class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    if @post.user_id != current_user.id   # 投稿者本人以外に限定
      @favorite = Favorite.create(user_id: current_user.id, post_id: @post.id)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id)
    @favorite.destroy
  end


end
