class ReservationMailerJob < ApplicationJob
  queue_as :default

  def perform(current_user, reservation)
    # Do something later
    UserMailer.reservation_email(current_user, reservation).deliver_now
  end
end
