class UsersController < Clearance::UsersController

	def create
		User.non_facebook_signup
		new_user = User.new(user_params)
		if new_user.save
			UserMailer.sign_up_email(new_user).deliver_later
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