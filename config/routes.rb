require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

  devise_for :users
	root to: "static_pages#home"
	get 'conditions', to: 'static_pages#conditions'
	resources :songs
	resources :searches
	resources :tracks

	post 'search_music', to: 'searches#search_music'
	get 'search_results', to: 'searches#search_results'
	get 'ruby_search', to: 'searches#ruby_search'
	post 'homepage_search', to: 'songs#homepage_search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
