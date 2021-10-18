# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'check changing failed_login_attempts' do
    it 'increases failed login attepnts upon invoiking failed login' do
      random_number = rand(3)
      user = create(:user, failed_login_attempts: random_number)
      user.failed_login
      expect(user.failed_login_attempts).to eq random_number + 1
    end

    it 'changes failed_login_attempts to -0 upon providing correct password' do
      random_number = rand(1..2)
      user = create(:user, failed_login_attempts: random_number)
      User.authenticate(user, 'password')
      expect(user.failed_login_attempts).to eq 0
    end
    it 'does not change failed_login_attempts upon providing incorrect password' do
      random_number = rand(1..2)
      user = create(:user, failed_login_attempts: random_number)
      User.authenticate(user, 'incorrect_password')
      expect(user.failed_login_attempts).to eq random_number
    end
  end

  describe 'check authorize method results' do
    it 'returns true when right password is given, and false if not' do
      password = Faker::Internet.password
      salt = BCrypt::Engine.generate_salt
      user = create(:user, password: BCrypt::Engine.hash_secret(password, salt), salt: salt)
      expect(User.authenticate(user, password)).to be true
      expect(User.authenticate(user, password + rand(65..89).chr)).to be false
    end
  end
end
