class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_one :payment
  validate :booking_start_date_in_future, :booking_end_date_after_booking_start_date
  enum status: [ :pending, :confirmed ]
  before_save :default_status

  def default_status
  	self.status = 0
  end

  def check_reservation_dates
		self.listing.reservations.each do |reservation|
			check_overlap = (reservation.booking_start - self.booking_end) * (self.booking_start - reservation.booking_end)
			return false if check_overlap >= 0
		end
		return true
	end

	def booking_start_date_in_future
		if self.booking_start < Date.today
			errors.add(:reservation_dates, 'Check-in dates can\'t be in the past')
		end
	end

	def booking_end_date_after_booking_start_date
		if self.booking_start > self.booking_end
			errors.add(:reservation_dates, 'Check-out dates need to be after check-in')
		end
	end
end