require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # this is an index page 
  # should expect logic for redirects to login, and signup
  get '/' do  
    erb :index
  end


  get '/login' do 
    
    if logged_in? # if a user session isnt already live, populate the signup
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
  
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Your login information is incorrect"
      redirect '/login'
    end
  end

helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by_id(session[:id])
    end
  end














end