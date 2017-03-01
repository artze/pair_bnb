class PaymentsController < ApplicationController
	def new
		gon.client_token = Braintree::ClientToken.generate
	end

	def checkout
    selected_reservation = Reservation.find_by(id: params[:reservation_id])
    amount_due = (selected_reservation.booking_end - selected_reservation.booking_start) * selected_reservation.listing.price
		nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

  	result = Braintree::Transaction.sale(
  		amount: amount_due.to_s,
  		payment_method_nonce: nonce_from_the_client,
  		options: {
  			submit_for_settlement: true
  		}
  	)

  	if result.success?
      selected_reservation.confirmed!
      @payment = Payment.new(reservation_id: selected_reservation.id, total_amount: amount_due)
      @payment.save
  		redirect_to :root, flash: { success: 'Transaction successful!' }
  	else
  		redirect_to :root, flash: { error: 'Transaction failed. Please try again.' }
  	end
	end
end
