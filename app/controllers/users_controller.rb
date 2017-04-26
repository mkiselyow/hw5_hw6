	class UsersController < ApplicationController
	require 'roo'
	
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
			render "new"
		end
	end

	def index
		@users = User.order(:username).paginate(page: params[:page])
		respond_to do |format|
			format.html
			format.xls #{ send_data @users.to_csv(col_sep: "\t") }
			format.csv { send_data @users.to_csv}
		end
	end

	def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
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

  
end
