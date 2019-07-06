require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'index'
  end

helpers do
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

  def params_present?
    params[:username].present? && params[:password].present? && params[:email].present? || params[:content].present?
  end

  def valid_login?
    user = User.find_by(username: params[:username])
    user.authenticate(params[:password])
  end

end

end
