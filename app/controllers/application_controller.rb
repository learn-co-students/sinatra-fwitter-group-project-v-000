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



  # Signup with a username, login, password
  # If a session is logged in - it should redirect to the users page
  get '/signup' do 
    if logged_in?  # if a user session isnt already live, populate the signup
      redirect to '/tweets'
    else
      erb :'/signup'
    end
  end

  # catches the signup params - creates a new user - and logs them into the tweets homepage
  post '/signup' do 
    if params.values.any? { |el| el.empty? }
       flash[:message] = "You must enter all fields!"
      redirect to '/signup'
    else 
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:id] = @user.id
      redirect to '/tweets'
    end
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

  get '/logout' do 
    session.clear
    flash[:message] = "You're logged out!"
    redirect to '/login'
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