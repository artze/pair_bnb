module ReservationsHelper
	def display_reservation_status(reservation)
		if reservation.confirmed?
			return {
				badge_class: 'success',
				display: 'Confirmed'
			 }
		else
			return {
				badge_class: 'danger',
				display: 'Payment pending'
			}
		end
	end
end