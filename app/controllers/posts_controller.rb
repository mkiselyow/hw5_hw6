class PostsController < ApplicationController
  def new
  end

  # def create
  #   @post=Post.new(params[:post].permit(:title,:body))
  #   @post.save
  #   redirect_to "new"
  # end

  def create
    @post = Post.create(params[:post])
    redirect_to new_post_path, notice: "Post published!" 
  end

  private

  def post_params
    params.require(:post).permit(:title,:body)
  end

  def show
    @post=Post.find(params[:id])
  end
end