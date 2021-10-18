# frozen_string_literal: true

describe 'the signin process', type: :feature do
  let(:user) { create(:user) }

  it 'signs me in' do
    visit 'login'
    within('#session') do
      fill_in 'Name', with: user.handle
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'logged in! YAY'
  end

  it 'Does not sign me in if password is invalid' do
    visit 'login'
    within('#session') do
      fill_in 'Name', with: user.handle
      fill_in 'Password', with: 'other password'
    end
    click_button 'Log in'
    last_user = User.last
    expect(page).to have_content 'password is invalid'
    expect(last_user.failed_login_attempts).to eq 1
  end
  it 'blocks me from signign in upon failing login attempt 3 times' do
    visit 'login'
    4.times do |_i|
      within('#session') do
        fill_in 'Name', with: user.handle
        fill_in 'Password', with: 'other password'
      end
      click_button 'Log in'
    end
    last_user = User.last
    expect(page).to have_content 'User has been blocked from logging in'
    expect(last_user.failed_login_attempts).to eq 3
  end

  it 'logs me out' do
    visit 'login'
    within('#session') do
      fill_in 'Name', with: user.handle
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_link('Log out', href: logout_url)
    click_link 'Log out'

    expect(page).to have_content 'Logged out'
  end
end
