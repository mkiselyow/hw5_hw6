	class UsersController < ApplicationController
	require 'roo'
	before_filter :authorize,      only: [:edit, :update]
	before_filter :correct_user,   only: [:edit, :update]
	before_filter :admin_user,     only: :destroy
  
	
	# before_filter :check_auth
	# before_filter :book, only: [:show, :edit, :update, :destroy]
	
	# before_filter :book, except: [:index, :new, :create] 
	# исключаем Actions (аналог вариата на второй строке)
	
	# skip_before_filter :check_auth, only: [:index] 
	
	# исключаем для индекса проверку

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			session[:user_id] = @user.id
			sign_in @user
			redirect_to @user, notice: "Thank you for signing up!"
		else
			flash.now[:error] = 'Invalid email/password combination'
			render "new"
		end
	end

	def index
    if params[:search]
      @users = User.order(:username).paginate(page: params[:page]).find(:all, :conditions => ['username LIKE ?', "%#{params[:search]}%"])
    else
  		@users = User.order(:username).paginate(page: params[:page])
  		respond_to do |format|
  			format.html
  			format.xls #{ send_data @users.to_csv(col_sep: "\t") }
  			format.csv { send_data @users.to_csv}
      end
		end
	end

	def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
    	sign_in @user
      redirect_to @user, notice: "Updated!"
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

	# def index
 #    flash[:notice] = "Lorem Ipsum"
 #    order = params[:order] || 'asc'
 #    @users = User.order("id #{order}")
 #    if params[:redirect]
 #      redirect_to 'http://google.com' and return
 #    else
 #      render action: :index
 #    end
 #  end
  

	# def index
	# 	@users = User.all
	# 	# binding.pry
	# 	order = params[:order] || 'ask'
	# 	@users = User.order("id #{order}")
	# 	if params[:redirect]
	# 		redirect_to 'http://google.com' and return 
	# 		# return не позволит дальше выпоняться коду
	# 		#можем перенаправить и сделать запрос
	# 	else
	# 		# с теми же данными рендер делает интерпретацию и не может делать запрос
	# 		render text: "Hello world !"
	# 		# делает генерацию того что мы запросили
	# 	end



		#параметры ? :key = &
		# @import = User::Import.new

	# 	respond_to do |format|
	# 		format.html
	# 		format.csv { send_data @users.to_csv }
	# 		format.xls  { send_data @users.to_csv(col_sep: "\t") }
	# 	end
	# end


	def import
		User.import(params[:file])
		redirect_to root_url, notice: "Users imported."
	end

	private

	def check_auth
		p 'CHECKAUTHORIZATION'
	end

	def book
		@book ||= Book.find(params[:id])
	end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end
end
