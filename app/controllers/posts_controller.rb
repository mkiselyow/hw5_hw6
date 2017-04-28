class PostsController < ApplicationController
  before_filter :authorize, only: [:edit, :destroy, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'static_pages/home'
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
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, :notice => 'The Post has been deleted!'
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to posts_path, :notice => 'The Post is Updated'
    else
      render "edit"
    end
  end
end