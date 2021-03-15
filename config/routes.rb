Rails.application.routes.draw do

  devise_for :users
	root to: "static_pages#home"
	resources :songs
	resources :searches

	post 'search_music', to: 'searches#search_music'
	get 'search_results', to: 'searches#search_results'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
