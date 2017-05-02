class PostsController < ApplicationController
  before_filter :authorize, only: [:edit, :destroy, :update]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(params[:post])
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

  def index
    @posts = Post.order(:created_at).paginate(page: params[:page])
    @post = current_user.posts.build if signed_in?
  end

  def post_params
    params.require(:post).permit(:title,:body)
  end

  def show
    @post=Post.find(params[:title])
  end

  def edit
    @post = Post.find(params[:id])
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

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to posts_path, :notice => 'The Post is Updated'
    else
      render "edit"
    end
  end
  private

    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_url, :notice => 'Can\'t' if @post.nil? 
    end
end