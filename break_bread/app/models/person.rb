class Person < ApplicationRecord
	belongs_to :user
	has_many :restaurants
	validates :name, :address, :birth_date
end
