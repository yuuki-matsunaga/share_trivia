class UsersController < ApplicationController

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    # @user = User.where.not(id: current_user.id) <自分以外を探す>
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    @user = current_user
    if @user.update(is_active: false)
      reset_session
      redirect_to root_path
    end
  end

  #--レベルアップ機能--

  def levelUp
    @user = User.find(params[:id])

    totalExp = @user.exp
    #変数に現在のユーザーの経験値を入れる
    totalExp += @exp
    # 得られた経験値をユーザーの経験値に加算

    @user.exp = totalExp
    #改めて、加算した経験値をuserの総経験値を示す変数に入れ直す
    @user.update(exp: totalExp)
    #更新の処理をさせる

    @levelSetting = LevelSetting.find_by(level: user.level + 1);
    #レベルセッティングのモデルから、今の自分のレベルより1高いレコードを探させる。
    #そしてそれを変数に入れる

    if @levelSetting.thresold <= user.exp
    #探してきたレコードの閾値よりもユーザーの総経験値が高かった場合
      @user.level = user.level + 1
      @user.update(level: user.level)
    #レベルを1増やして更新
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :comment, :is_active, :level, :exp)
  end

end
