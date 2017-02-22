class UsersController < Clearance::UsersController

	def create
		new_user = User.new(user_params)
		if new_user.save
			sign_in(new_user)
			redirect_to root_path
		else
			respond_to do |format|
				format.html { redirect_to sign_up_path }
				format.js {}
			end
		end
	end

	def edit

	end

	private

	def user_params
		params[:user].permit(:email, :password, :first_name, :last_name)
	end

end