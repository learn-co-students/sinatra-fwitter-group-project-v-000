require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    binding.pry
    erb :'/application/index'
  end

  get '/signup' do
    #binding.pry

    #binding.pry
    if logged_in?
      #binding.pry
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

  helpers do
      def logged_in?
        binding.pry
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end
    end
end
