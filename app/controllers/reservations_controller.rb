class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing_id = params[:listing_id]
		if @reservation.check_reservation_dates
			if @reservation.save
				redirect_to listing_path(params[:listing_id]), notice: 'You have successfully booked the property below!'
			else
				redirect_to new_listing_reservation_path, notice: @reservation.errors[:reservation_dates].first
			end
		else
			redirect_to new_listing_reservation_path, notice: 'Property not available on these dates.'
		end
	end

	private

	def reservation_params
		params[:reservation].permit(:user_id, :listing_id, :booking_start, :booking_end)
	end
end
