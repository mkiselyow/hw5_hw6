class StaticPagesController < ApplicationController

  def index
    if signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def destroy
  end

  def create
  end


  def show
  end

  def update_users_list
    
  end
end
