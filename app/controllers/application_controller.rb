require './config/environment'
require "sinatra/reloader"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Reloader
    enable :reloader
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :homepage
  end

  get '/users/:user_slug' do
    @user = User.find_by_slug(params[:user_slug])
    erb :"users/show"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end
    def current_user
      User.find(session[:id])
    end
  end
  
end