class ApplicationController < ActionController::Base
  before_action :set_headers

  def set_headers
    if session[:jwt]
      @jwt = session[:jwt]
      Unirest.default_header("Authorization", "Bearer #{session[:jwt]}")
    else
      Unirest.clear_default_headers()
    end
  end

  protect_from_forgery with: :exception
end
