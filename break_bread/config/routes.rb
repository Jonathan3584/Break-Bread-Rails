Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get "/users/validate", to: "users#validate"
	# puts ('routes.rb')
  post "/users", to: "users#create"
  post "/login", to: "sessions#create"

  resources :people do
  	resources :restaurants, only: [:index, :create, :destroy]
  	post "/people/:id/restaurants/search", to: "restaurants#search"
  end

end
