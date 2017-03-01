class SignUpMailerJob < ApplicationJob
  queue_as :default

  def perform(new_user)
    # Do something later
    UserMailer.sign_up_email(new_user).deliver_now
  end
end