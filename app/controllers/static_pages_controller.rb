class StaticPagesController < ApplicationController

  def index
    if signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def destroy
    @post.destroy
    # redirect_to root_path, :notice => 'The Post has been deleted!'
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.js { render :layout => false }
      format.json { head :no_content }
    end
  end

  def create
    @post = current_user.posts.build(params[:post])
    @feed_items = current_user.feed.paginate(page: params[:page])
    respond_to do |format|
      if @post.save
        flash[:success] = "Post created!"
        format.html { redirect_to @post }
        format.js 
        format.json { render json: @post, status: :created, location: @post }
      else
        flash.now[:error] = "your message"
        @feed_items = []
        render 'static_pages/home'
      end
    end
  end


  def show
    if signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
