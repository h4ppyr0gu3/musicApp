require 'sidekiq/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

  devise_for :users
	root to: "static_pages#home"
	get 'terms', to: 'static_pages#terms_of_use'
	get 'contact', to: 'static_pages#contact'
	get 'copyright', to: 'static_pages#copyright_claims'
	get 'privacy', to: 'static_pages#privacy_policy'
	resources :songs
	resources :searches
	resources :tracks
	resources :contact_emails, only: :create

	post 'search_music', to: 'searches#search_music'
	get 'search_results', to: 'searches#search_results'
	get 'ruby_search', to: 'searches#ruby_search'
	post 'homepage_search', to: 'songs#homepage_search'
	post 'contact_mail', to: 'static_pages#contact_mail'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
