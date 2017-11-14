class Person < ApplicationRecord
	belongs_to :user
	validates :name, :address, :birth_date
end
