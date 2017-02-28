class UserMailer < ApplicationMailer
	default from: 'pairbnb733@gmail.com'
	def sign_up_email(user)
		@user = user
		email_with_name = %("#{@user.first_name + ' ' + @user.last_name}" <#{@user.email}>)
		mail(to: email_with_name,
			subject: 'Welcome to PairBnb!',
			template_path: 'user_mailer',
			template_name: 'sign_up_email')
	end
end