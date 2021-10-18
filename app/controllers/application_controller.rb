# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorize_user
  def index; end

  protected

  def authorize_user
    return if session[:user_id] && User.find_by(id: session[:user_id])

    redirect_to login_path, notice: 'you must be logged in'
  end
end
