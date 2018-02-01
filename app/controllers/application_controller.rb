require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  def self.current_user(session)
    User.find_by(id: session[:user_id])
  end

  def self.is_logged_in?(session)
    session[:user_id] != nil
  end

  get '/' do
    erb :'/application/index'
  end

  get '/signup' do
     binding.pry
    if self.class.is_logged_in?(session)
  #    binding.pry
    redirect '/tweets'
  else
    erb :'/application/signup'
  end
  end

  post '/signup' do
    redirect '/signup' if params["username"].empty?
    redirect '/signup' if params["email"].empty?
    redirect '/signup' if params["password"].empty?
    redirect '/tweets'
  end



end
