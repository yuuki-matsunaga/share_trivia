class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]


  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user
      redirect_to root_path
    end
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)

    @post.user_id = current_user.id
    if @post.save
      @user = current_user

      totalExp = @user.exp
      #変数に現在のユーザーの経験値を入れる
      totalExp += 50
      # 得られた経験値をユーザーの経験値に加算

      @user.exp = totalExp
      #改めて、加算した経験値をuserの総経験値を示す変数に入れ直す
      @user.update(exp: totalExp)
      #更新の処理をさせる


      @levelSetting = LevelSetting.find_by(level: @user.level + 1);

      #レベルセッティングのモデルから、今の自分のレベルより1高いレコードを探させる。

      if @levelSetting.thresold <= @user.exp
      #探してきたレコードの閾値よりもユーザーの総経験値が高かった場合
        @user.level = @user.level + 1
        @user.update(level: @user.level)
        redirect_to user_level_up_path(@user)
      else

        redirect_to post_path(@post)
      end

    else
      render :new
    end

  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :introduction, :image)
  end

end
