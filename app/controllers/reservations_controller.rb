class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing_id = params[:listing_id]
		if @reservation.check_reservation_dates
			if @reservation.save
				render text: 'reservation successful'
			else
				render text: 'reservation failed'
			end
		else
			render text: 'reservation failed'
		end
	end

	private

	def reservation_params
		params[:reservation].permit(:user_id, :listing_id, :booking_start, :booking_end)
	end
end
