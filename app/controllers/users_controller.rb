class UsersController < ApplicationController
	def index
		@users = User.all
		# @import = User::Import.new

		respond_to do |format|
			format.html
			# format.csv { send_data @users.to_csv }
			format.csv { send_data @users.to_csv }
			format.xls  { send_data @users.to_csv(col_sep: "\t") }
		end
	end


	def import
		User.import(params[:file])
		redirect_to root_url, notice: "Users imported."
	end
end
