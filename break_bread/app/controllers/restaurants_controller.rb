class RestaurantsController < ApplicationController

	def index
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
	end

	private

	def set_person
		@person = Person.find([params[:person_id]])
	end

	def restaurant_params
		params.require(:restaurant).permit(:name, :category, :url, :rating, :photo)
	end


end
