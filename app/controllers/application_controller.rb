require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/signup' do
    erb :'users/create_users'
  end

  post '/signup' do
    user = User.new(params[:user])
    if user.save
      user_log_in(user)

    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])

    user_log_in(user)
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
    erb :index
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
        redirect '/success'
      else
        redirect '/failure'
      end
    end
  end
end
