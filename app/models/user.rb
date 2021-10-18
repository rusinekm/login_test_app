# frozen_string_literal: true

require 'bcrypt'
class User < ApplicationRecord
  include BCrypt

  def self.find_by_login(login_handle)
    User.find_by(handle: login_handle)
  end

  def self.authenticate(user, password)
    pw = BCrypt::Engine.hash_secret(password, user.salt)
    user.update!(failed_login_attempts: 0) if pw == user.password
    pw == user.password
  end

  def failed_login
    increment!(:failed_login_attempts)
  end
end
