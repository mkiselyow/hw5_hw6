class PostsController < ApplicationController
  before_filter :authorize, only: [:edit, :destroy, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to users_path, notice: "Post published!"
    else
      render "new"
    end
  end

  def index
    @posts = Post.order(:created_at).paginate(page: params[:page])
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