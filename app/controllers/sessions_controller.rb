# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize_user, only: %i[new create]
  before_action :only_unauthorised, only: %i[new create]

  def new; end

  def create
    user = User.find_by_login(params[:name])
    if user.nil?
      flash.now.alert = 'login is invalid'
      render 'new'

    else
      check_user_authentication(user)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: 'Logged out'
  end

  protected

  def only_unauthorised
    return unless session[:user_id] && User.find_by(id: session[:user_id])

    redirect_to root_index_path,
                notice: 'already logged in'
  end

  def check_user_authentication(user)
    if user.failed_login_attempts >= 3
      flash.now.alert = 'User has been blocked from logging in'
      render 'new'
      return
    end
    if User.authenticate(user, params[:password])
      session[:user_id] = user.id
      redirect_to root_index_path, notice: 'logged in! YAY'
    else
      user.failed_login
      flash.now.alert = 'password is invalid'
      render 'new'
    end
  end
end
