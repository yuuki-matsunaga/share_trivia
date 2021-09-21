class HomesController < ApplicationController

  def top
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

end
