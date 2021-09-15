class PostsController < ApplicationController

  def new
    @post = Post.new
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      puts "保存に成功しました"
    else
      puts "保存に失敗しました"
    end
    redirect_to post_path(post)
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @comment = Comment.new
    @comment.user_id = current_user.id
  end

  def destroy
    @post = Post.find(params[:id])
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :introduction, :image)
  end


end
