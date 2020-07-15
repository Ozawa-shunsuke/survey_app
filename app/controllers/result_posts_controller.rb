class ResultPostsController < ApplicationController
  
  def create
    ResultPost.create(user_id: current_user.id, choice_id: params[:choice_id], post_id: params[:post_id])
    flash[:success] = "投票完了"
    redirect_back(fallback_location: root_path)
  end
end
