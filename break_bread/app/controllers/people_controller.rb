class PeopleController < ApplicationController
	before_action :set_person, only: [:show, :update, :destroy]
	
	def index
		@people = Person.where(user_id = params[:user_id])
		render json: @people
	end
	
	def create
		@person = Person.create(person_params)
		render json: @person
	end
	
	def show
		render json: @person
	end
	
	def update
		@person.update(person_params)
		render json: @person
	end
	
	def destroy
		@person.destroy
		render json: @person.destroy
	end

	private

	def set_person
		@person = Person.find(params[:id])
	end
	
	def person_params
		params.require(:person).permit(:name, :address, :relationship, :birth_date, :user_id, :budget)
	end

end
