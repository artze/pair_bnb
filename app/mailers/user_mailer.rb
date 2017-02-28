class UserMailer < ApplicationMailer
	default from: 'pairbnb733@gmail.com'

	def email_with_name(user)
		%("#{user.first_name + ' ' + user.last_name}" <#{user.email}>)
	end

	def sign_up_email(user)
		@user = user
		mail(to: email_with_name(user),
			subject: 'Welcome to PairBnb!',
			template_path: 'user_mailer',
			template_name: 'sign_up_email')
	end

	def reservation_email(user, reservation)
		@user = user
		@reservation = reservation
		mail(to: email_with_name(user),
			subject: 'Your PairBnb booking',
			template_path: 'user_mailer',
			template_name: 'reservation_email')
	end
end