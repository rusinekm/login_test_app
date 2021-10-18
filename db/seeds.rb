# frozen_string_literal: true

salt = BCrypt::Engine.generate_salt
User.create(handle: 'test', password: BCrypt::Engine.hash_secret('password', salt), salt: salt)
