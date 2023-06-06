require 'rails_helper'

RSpec.describe 'User login', type: :feature do
  let!(:manager) { FactoryBot.create(:user, role: 'manager') }

  scenario 'User login with valid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: manager.email
    fill_in 'Password', with: manager.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'User login with Invalid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: 'member@gmail.com'
    fill_in 'Password', with: 'password12'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end
end
