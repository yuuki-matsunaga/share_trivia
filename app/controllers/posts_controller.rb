class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def index
  end

  def show
  end

  def destroy
  end

  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :introduction, :image)
  end

end
