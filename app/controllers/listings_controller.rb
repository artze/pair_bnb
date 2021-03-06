class ListingsController < ApplicationController
	before_action :require_login

	def index
		if params[:user_id]
			@listings = Listing.where(user_id: params[:user_id]).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
		else
			@listings = Listing.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
		end
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
				flash[:success] = 'Listing submitted!'
				redirect_to listings_path
			else
				flash[:error] = 'All fields are required'
				redirect_to new_user_listing_path(current_user)
			end
		end
	end

	def edit
		@listing = Listing.find_by(id: params[:id], user_id: current_user.id)
	end

	def update
		@listing = Listing.find_by(id: params[:id], user_id: current_user.id)
		if @listing.update(listing_params)
			flash[:success] = 'Listing updated'
			redirect_to listing_path(@listing)
		else
			flash[:error] = 'Update failed'
			redirect_to edit_user_listing_path(current_user, @listing)
		end
	end

	def destroy 
		Listing.find_by(id: params[:id], user_id: current_user.id).destroy
		flash[:success] = 'Listing removed'
		redirect_to user_listings_path(current_user)
	end

	def search
		@listings = Listing.search(params[:location_search], params[:tag_ids]).paginate(page: params[:page], per_page: 10)
		flash.now[:notice] = 'Your search query did not return any results' if @listings.empty?
		render 'listings/index'
	end

	private

	def listing_params
		params[:listing].permit(:title, :description, :price, :street_address, :postcode, :city, :country, :home_type, :room_type, :bedroom, :bathroom, :accommodate, :user_id, {images: []}, tag_ids: [])
	end

end