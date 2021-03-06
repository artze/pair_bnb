class SessionsController < Clearance::SessionsController

	def create
		@user = authenticate(params)
		sign_in(@user) do |status|
			if status.success?
				redirect_to root_url
			else
				respond_to do |format|
					format.html { redirect_to sign_in_path }
					format.js {}
				end
			end
		end
	end

	def create_from_omniauth
		User.facebook_signup
		auth_hash = request.env['omniauth.auth']
		authentication = Authentication.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid]) || Authentication.create_with_omniauth(auth_hash)

		if authentication.user
			user = authentication.user
			authentication.update_token(auth_hash)
			@next = root_url
			@notice = "Signed in!"
		else
			user = User.create_with_auth_and_hash(authentication,auth_hash)
			@notice = "User created!"
		end
		sign_in(user)
		redirect_to root_path, notice: @notice
	end
end
