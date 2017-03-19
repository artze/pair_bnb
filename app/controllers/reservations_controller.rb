class ReservationsController < ApplicationController
	before_action :redirect, unless: :reservation_authority, only: [:index, :show]

	def index
		@reservations = Reservation.where(user_id: current_user.id)
		flash.now[:notice] = 'You have not made any bookings' if @reservations.empty?
	end

	def show
		@reservation = Reservation.find_by(id: params[:id])
	end

	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing_id = params[:listing_id]
		if @reservation.check_reservation_dates
			if @reservation.save
				ReservationMailerJob.perform_later(current_user, @reservation)
				flash[:success] = 'You have reserved the property. Pay to secure booking.'
				redirect_to new_reservation_payment_path(@reservation)
			else
				flash[:error] = @reservation.errors[:reservation_dates].first
				redirect_to new_listing_reservation_path
			end
		else
			flash[:error] = 'Property not available on these dates.'
			redirect_to new_listing_reservation_path
		end
	end

	def destroy
		Reservation.find_by(id: params[:id], user_id: current_user.id).destroy
		flash[:success] = 'Reservation cancelled'
		redirect_to user_reservations_path(current_user)
	end

	private

	def reservation_params
		params[:reservation].permit(:user_id, :listing_id, :booking_start, :booking_end, :status)
	end

	def reservation_authority
		params[:user_id].to_i == current_user.id
	end

	def redirect
		redirect_to root_path, flash: { error: 'Permission denied' }
	end

end
