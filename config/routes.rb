require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}
	root to: "static_pages#home"
	
	resources :songs, only: %i[all_songs create destroy confirm index edit_again all_tracks destroy_tracks tracks_index create_tracks]
	resources :searches, only: %i[search_results search_music]
	resources :contact_emails, only: :create
	resources :profile, only: %i[add index update settings]
	# resources :playlists#, only: %i[add_to_favourites create get_playlists, add_song, view]

	get 'music', to: 'react#show', constraints: { subdomain: 'music' }

	get 'privacy', to: 'static_pages#privacy_policy'
	post 'contact_mail', to: 'static_pages#contact_mail'
	get 'contact', to: 'static_pages#contact'
	get 'terms', to: 'static_pages#terms_of_use'
	get 'copyright', to: 'static_pages#copyright_claims'

	get 'add', to: 'profile#add'
	get 'settings', to: 'profile#settings'
	
	post 'search_music', to: 'searches#search_music'
	get 'search_results', to: 'searches#search_results'
	get 'ruby_search', to: 'searches#ruby_search'
	
	post 'homepage_search', to: 'songs#homepage_search'
	get 'all_songs', to: 'songs#all_songs'
	post 'edit_again', to: 'songs#edit_again'
	post 'create_tracks', to: 'songs#create_tracks'
	get 'tracks', to: 'songs#all_tracks'
	get 'tracks_index', to: 'songs#tracks_index'
	delete 'tracks/:id', to: 'songs#destroy_tracks'
	post 'attributes', to: 'songs#confirm'

<<<<<<< HEAD
	get 'favourites', to: 'playlists#favourites'
	get 'index', to: 'playlists#index', as: 'playlists'
	post 'add_to_favourites', to: 'playlists#add_to_favourites'
	get 'get_playlists', to: 'playlists#get_playlists'
	post 'add_song', to: 'playlists#add_song'
	get 'playlist/:id', to: 'playlists#show', as: 'playlist'
	post 'playlists', to: 'playlists#create'
=======
	# get 'index', to: 'playlists#index'
	# post 'add_to_favourites', to: 'playlists#add_to_favourites'
	# get 'get_playlists', to: 'playlists#get_playlists'
	# post 'add_song', to: 'playlists#add_song'
	# get 'render/:id', to: 'playlists#render', as: 'render'
	# get 'favourites', to: 'playlists#favourites'
>>>>>>> playlists
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :playlists do
  	resources :favourites
  	resources :playlists
  	resources :tracks

  	get 'playlists_api', to: 'playlists#index_api'
  	get 'favourites_api', to: 'favourites#index_api'
  	get 'tracks_api', to: 'tracks#index_api'
  	# get 'playlists', to: 'playlists#index'


  end
end
