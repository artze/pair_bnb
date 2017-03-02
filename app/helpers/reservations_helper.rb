module ReservationsHelper
	def reservation_status(reservation)
		return true if reservation.status == 'confirmed'
	end
end
