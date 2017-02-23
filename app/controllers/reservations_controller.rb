class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing_id = params[:listing_id]
		if @reservation.check_reservation_dates
			if @reservation.save
				redirect_to root_path, notice: 'Reservation successful'
			else
				redirect_to new_listing_reservation_path, notice: 'Reservation failed'
			end
		else
			redirect_to new_listing_reservation_path, notice: 'Reservation failed'
		end
	end

	private

	def reservation_params
		params[:reservation].permit(:user_id, :listing_id, :booking_start, :booking_end)
	end
end
