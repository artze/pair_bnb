class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  def check_reservation_dates
		self.listing.reservations.each do |reservation|
			check_overlap = (reservation.booking_start - self.booking_end) * (self.booking_start - reservation.booking_end)
			return false if check_overlap >= 0
		end
		return true
	end
end