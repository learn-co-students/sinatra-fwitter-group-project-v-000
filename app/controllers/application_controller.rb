require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions unless test?
    set :session_secret, "imnottelling"
  end

  get '/' do
    erb :'/index'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    # check if credentials are good, set session?
    if params[:username] != "" && params[:password] != ""
      # go to the account page
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        # erb :'/tweets/tweets'
        redirect "/tweets"
      end
    else
      redirect "/failure"
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    # create the user if it doesn't already exist
    if params[:username] != "" && params[:password] != "" && params[:email] != ""
      @user = User.new(username: params[:username], password: params[:password])
      @user.save

      session[:user_id] = @user.id

      redirect "/tweets"
    else
      redirect "/signup"
    end
    # go to user homepage
  end

  get '/failure' do
    # for now this just redirects to /signup
    redirect "/signup"
  end

  # home page
  get '/home' do
    # @user = User.find(session[:user_id])
    # erb :'/tweets/tweets'
    redirect "/"
  end

  get '/tweets' do
    @user = User.find(session[:user_id])
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    # create a new tweet if logged in
  end


  get '/pry' do
    binding.pry
  end

  # Helper Methods
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
