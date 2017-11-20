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
		@restaurant = Restaurant.find(params[:id])
		@restaurant.destroy
		render json: @restaurant.destroy
	end

	def search
		# This API call converts the address into usable lat/long for the second API call
		
		@address = @person.address.sub!(' ', '+')
		puts @address
		url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@address}&key=#{ENV['GOOGLE_API']}"
		results = HTTParty.get(url)
		@lat = JSON.parse(results.body)["results"][0]["geometry"]["location"]["lat"].round(1)
		@lng = JSON.parse(results.body)["results"][0]["geometry"]["location"]["lng"].round(1)

		if @person.budget < 50 
			 @price = "1,2" 
		 
			elsif @person.budget < 75 
				 @price = "2" 
			
			elsif @person.budget < 100 
				 @price = "2,3" 
			 
			elsif @person.budget < 150 
				 @price = "3" 
			
			elsif @person.budget < 200 
				 @price = "3,4" 
			
			else  @price = "4" 
		end
		puts @price

		# This API call returns the data for the restaurant search
		newrl = "https://api.foursquare.com/v2/venues/explore?client_id=#{ENV['FOUR_SQUARE_API_ID']}&client_secret=#{ENV['FOUR_SQUARE_API_SECRET']}&ll=#{@lat},#{@lng}&radius=4800&section=food&limit=20&price=#{@price}&v=20171111"
		puts newrl
		
		response = HTTParty.get(newrl)
		parsed_response = JSON.parse(response.body)["response"]["groups"][0]["items"].map do |venue|
			
			{ 
				:name => venue["venue"]["name"],
				:category => venue["venue"]["categories"][0]["name"],
				:url => venue["venue"]["url"],
				:rating => venue["venue"]["rating"],
				:photo => "#{venue["venue"]["categories"][0]["icon"]["prefix"]}" + "#{venue["venue"]["categories"][0]["icon"]["suffix"]}"
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
