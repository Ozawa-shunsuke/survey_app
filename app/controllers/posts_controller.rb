class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

 # def index
    #@posts = Post.all.order(created_at: :desc)
  #end
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
        @choice = Choice.create(post_id: @post.id, item: params[:post][:choice][:item_1])
                  Choice.create(post_id: @post.id, item: params[:post][:choice][:item_2])
                  
       if params[:post][:choice][:item_1] != "" && params[:post][:choice][:item_2] != ""
         if params[:post][:choice][:item_1] == params[:post][:choice][:item_2]
           flash.now[:danger] = "各選択肢には違う内容を入れてください"
           render 'new'  
         else
         flash[:success] = "Post created!"
         redirect_to post_path(@post)
         end
       else
        flash[:danger] = "選択肢が足りません"
        render "new"
       end
     else
       render "new"     
     end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  def new
    @post       = current_user.posts.build
    @choice = @post.choices.build
    @post.choices.build
  end
  
  def update
      @post = Post.find_by(id: params[:id])
      @choice1 = Choice.where(post_id: @post.id).first
      @choice2 = Choice.where(post_id: @post.id).second
      @choice = @choice1 ,@choice2
      @post.update(title: params[:post][:title] , description: params[:post][:description])
      
     if params[:post][:choice][:item_1] != "" && params[:post][:choice][:item_2] != ""
      if params[:post][:choice][:item_1] == params[:post][:choice][:item_2]
        flash.now[:danger] = "各選択肢には違う内容を入れてください"
        render 'new'
      else
      if @choice1.nil?
        Choice.create(post_id: @post.id, item: params[:post][:choice][:item_1])
      else
        @choice1.update(item: params[:post][:choice][:item_1])
      end
      if @choice2.nil?
        Choice.create(post_id: @post.id, item: params[:post][:choice][:item_2])
      else
         @choice2.update(item: params[:post][:choice][:item_2])
      end
         flash[:success] = "Post created!"
         redirect_to post_path(@post)
      end
     else
        flash.now[:danger] = "選択肢が足りません"
        render "new"
     end
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def search
    @q = Post.search(search_params)
    @posts = @q.result(distinct: true)
  end

  private
  
  def search_params
    params.require(:q).permit!
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end  
end
