require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "antimicrobial"
    use Rack::Flash
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if Helper.logged_in?(session)
      redirect :'/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    if params["username"].empty? || params["password"].empty?
      flash[:message] = "Both username and password required."
      erb :'/login'
    elsif @user = User.find_by(username: params["username"])
      if @user.authenticate(params["password"])
        session[:user_id] = @user.id
        redirect :'/tweets'
      end
    else
      flash[:message] = "Incorrect username or password."
      erb :'/login'
    end
  end

  get '/signup' do
    if Helper.logged_in?(session)
      redirect :'/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    if params["username"].empty? || params["email"].empty? || params["password"].empty?
      flash[:message] = "All fields required!"
      redirect :'/signup'
    elsif User.find_by(username: params["username"]) && !User.find_by(email: params["email"])
      flash[:message] = "Unfortunately, that username is taken. Please select another username."
      redirect :'/signup'
    ## This was a cool feature, but it broke the test suite. 
    # elsif User.find_by(email: params["email"])
    #   flash[:message] = "An account already exists with that email! Log in below:"
    #   redirect :'/login'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect :'/tweets'
    end
  end

  get '/logout' do
    if Helper.logged_in?(session)
      session.clear
      flash[:message] = "Successfully logged out."
      redirect :'/login'
    else
      redirect :'/'
    end
  end

end
