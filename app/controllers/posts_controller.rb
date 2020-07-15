class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index#オリジナル機能
    @posts = Post.all.order(created_at: :desc)#現状だとitem部分が表示されない
  end  
      
  def show
    @choice = Choice.where(post_id: params[:id])
    @count_choice_1 = ResultPost.where(post_id: params[:id], choice_id: Choice.where(post_id: params[:id]).first.id).length
    @count_choice_2 = ResultPost.where(post_id: params[:id], choice_id: Choice.where(post_id: params[:id]).second.id).length
    @post = Post.find_by(id: params[:id])
    @data = [[@choice.first.item, @count_choice_1], [@choice.second.item, @count_choice_2]] #ボタンのデータ
    ResultPost.find_by(post_id: params[:id], user_id: current_user.id)
    
    
  end

  def create
    @post = current_user.posts.build(title: params[:post][:title] , description: params[:post][:description])
    if @post.save
      Choice.create(post_id: @post.id, item: params[:post][:choice][:item_1])
      Choice.create(post_id: @post.id, item: params[:post][:choice][:item_2])
      flash[:success] = "Post created!"
      
      redirect_to("/posts/index")
    else
      @feed_items = []
      render "static_pages/home"
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end  
end
