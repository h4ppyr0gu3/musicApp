require 'spec_helper'

RSpec.describe 'visitor sign up', type: :feature do
 before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end
	it 'valid inputs' do
    visit root_path
    click_link 'Sign up'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
    expect(page).to have_current_path(root_path)
  end

  it 'invalid email' do
  	visit new_user_registration_path
    fill_in 'user[email]', with: 'test'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content("1 error prohibited this user from being saved:\nEmail is invalid")
  end

  it 'not matching passwords' do
  	visit new_user_registration_path
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'pass word'
    click_button 'Sign up'
    expect(page).to have_content("1 error prohibited this user from being saved:\nPassword confirmation doesn't match Password")
  end

  it 'invalid email and password' do
  	visit new_user_registration_path
    fill_in 'user[email]', with: 'test'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'pass word'
    click_button 'Sign up'
    expect(page).to have_content("2 errors prohibited this user from being saved:\nEmail is invalid\nPassword confirmation doesn't match Password")
  end

  it 'navbar button change on login/sign up' do
  	visit root_path 
  	expect(page).to have_link('Sign up')
  	expect(page).to have_link('Log in')
  	click_link 'Sign up'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
    expect(page).to have_current_path(root_path)
    expect(page).to have_css('.dropdown-trigger')
    find('.dropdown-trigger').click
  	expect(page).to have_link('Your Tracks')
  	expect(page).to have_link('Log Out')
    click_link 'Log Out'
    expect(page).to have_current_path(root_path)
    expect(page).to have_link('Sign up')
  	expect(page).to have_link('Log in')
  end

  it 'Oauth' do
    visit root_path 
    expect(page).to have_link('Sign up')
    expect(page).to have_link('Log in')
    click_link 'Sign up'
    find('.google').click
    click_link 'musicApp'
    expect(page).to have_current_path(root_path)
    expect(page).to have_css('.dropdown-trigger')
    find('.dropdown-trigger').click
    expect(page).to have_link('Your Tracks')
    expect(page).to have_link('Log Out')
    click_link 'Log Out'
  end
end