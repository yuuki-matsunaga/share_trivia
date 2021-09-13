class PostsController < ApplicationController

  def new
    @post = Post.new
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    binding.pry
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :introduction, :image)
  end


end
