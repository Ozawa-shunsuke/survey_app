class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @post       = current_user.posts.build
      @choice = @post.choices.build
      @post.choices.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def about
  end
  
  def contact
  end
end
