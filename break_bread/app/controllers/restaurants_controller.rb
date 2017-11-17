class RestaurantsController < ApplicationController
	before_action :set_person

	def index
		puts @person
		@restaurants = @person.restaurants
		render json: @restaurants
	end

	def create
		@restaurant = Restaurant.create(restaurant_params)
		render json: @restaurant	
	end

	def destroy
		@restaurant = Resaurant.find(params[:id])
		@restaurant.destroy
		render json: @restaurant.destroy
	end

	def search
		# This API call converts the address into usable lat/long for the second API call
		puts "request"
		puts request.inspect
		
		@address = @person.address.sub!(' ', '+')
		puts @address
		url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@address}&key=#{ENV['GOOGLE_API']}"
		results = HTTParty.get(url)
		@lat = JSON.parse(results.body)["results"][0]["geometry"]["location"]["lat"]
		@lng = JSON.parse(results.body)["results"][0]["geometry"]["location"]["lng"]
	
		# This API call returns the data for the restaurant search
		newrl = "https://api.foursquare.com/v2/venues/search?client_id=#{ENV['FOUR_SQUARE_API_ID']}&client_secret=#{ENV['FOUR_SQUARE_API_SECRET']}&ll=#{@lat},#{@lng}&query=dinner&v=20171111"
		puts newrl
		
		response = HTTParty.get(newrl)
		parsed_response = JSON.parse(response.body)["response"]["venues"].map do |venue|
			{ 
				:name => venue["name"],
				:address => venue["location"]["formattedAddress"]
			}
		end
		puts parsed_response
		render json: parsed_response
	end

	private

	def set_person
		@person = Person.find(params[:person_id])
	end

	def restaurant_params
		params.require(:restaurant).permit(:name, :category, :url, :rating, :photo, :person_id)
	end


end
