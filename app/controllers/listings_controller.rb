class ListingsController < ApplicationController
	def index
		@listings = Listing.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
	end

	def show
		@listing = Listing.find_by(id: params[:id])
	end

	def new
		@listing = Listing.new
	end

	def create
		if signed_out?
			redirect_to sign_in_path
		else
			@listing = current_user.listings.new(listing_params)
			if @listing.save
				redirect_to listings_path, notice: 'Listing submission successful'
			else
				redirect_to new_listing_path, notice: 'All fields are required'
			end
		end
	end

	private

	def listing_params
		params[:listing].permit(:title, :description, :price, :address, :home_type, :room_type, :bedroom, :bathroom, :accommodate, :user_id, tag_ids: [])
	end
end
