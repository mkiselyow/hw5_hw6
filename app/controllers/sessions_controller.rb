class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in"
    else
      flash.now.alert = "Email or password is wrong"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    sign_out
    redirect_to root_url, notice: "Logged Out!"
  end

  def home
    @post = current_user.posts.build if signed_in?
  end



  # def create
  #   @user = User.new(params[:user])
  #   if @user.save
  #     redirect_to root_url, notice: "Thank you for signing up!"
  #   else
  #     render "new"
  #   end
  # end
end
