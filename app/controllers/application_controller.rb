require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_users'
    end
  end

  post '/signup' do

    # binding.pry
    user = User.new(params[:user])
    if user.save
      user_log_in(user)
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    # binding.pry
    user = User.find_by(username: params[:user][:username])

    user_log_in(user)
  end

  get '/users/:slug' do
    # binding.pry
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

# test routes for user account testing - may not be necessary for final project build
  get '/success' do
    @user = current_user
    erb :'users/success'
  end

  # test routes for user account testing - may not be necessary for final project build
  get '/failure' do
    erb :'users/failure'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    # helper to avoid requiring a user to log in after creating account
    def user_log_in(user)
      # binding.pry
      if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect '/tweets'

      else
        redirect '/failure'
      end
    end
  end
end
