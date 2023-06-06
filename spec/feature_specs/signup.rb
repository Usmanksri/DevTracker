require 'rails_helper'

RSpec.describe 'User Signup', type: :feature do

  scenario 'User signup with valid credentials' do
    visit new_user_registration_path

    fill_in 'Name', with: 'member'
    fill_in 'Email', with: 'member11@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')

  end

  scenario 'User signup with InValid credentials' do
    visit new_user_registration_path

    fill_in 'Name', with: 'member'
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content("Email can't be blank")

  end

end
