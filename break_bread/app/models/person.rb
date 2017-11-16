class Person < ApplicationRecord
	belongs_to :user
	has_many :restaurants, dependent: :destroy
	validates :name, :address, :birth_date, presence: true
end
