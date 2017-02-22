class ListingsController < ApplicationController
	def index
		@listings = Listing.paginate(page: params[:page], per_page: 10)
	end
end
