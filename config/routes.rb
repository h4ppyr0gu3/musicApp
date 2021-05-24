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

  namespace :playlists do
  	resources :favourites
  	resources :playlists
  	resources :tracks

  	post 'update_playlist', to: 'playlists#update'
  	post 'update_favourites', to: 'favourites#update'
  	post 'update_tracks', to: 'tracks#update'

  	get 'playlists_api', to: 'playlists#index_api'
  	get 'show_api/:id', to: 'playlists#show_api'
  	get 'favourites_api', to: 'favourites#index_api'
  	get 'tracks_api', to: 'tracks#index_api'
  	post 'add_song', to: 'playlists#add_song'
  	# post 'add_song', to: 'playlists#add_song'


  end
end
