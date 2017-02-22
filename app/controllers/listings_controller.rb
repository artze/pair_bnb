class ListingsController < ApplicationController
	def index
		@listings = Listing.paginate(page: params[:page], per_page: 10)
	end

	def new
		@listing = Listing.new
	end

	def create
		if (signed_in? == false)
			redirect_to sign_in_path
		else
			@listing = current_user.listings.new(listing_params)
			if @listing.save
				render text: 'success'
			else
				render text: 'fail'
			end
		end
	end

	private

	def listing_params
		params[:listing].permit(:title, :description, :price, :address, :home_type, :room_type, :bedroom, :bathroom, :accommodate, :user_id)
	end
end
