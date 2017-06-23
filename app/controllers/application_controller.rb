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
    erb :'users/create_users'
  end

  post '/signup' do
    user = User.new(params[:user])
    if user.save
      user_log_in(user)
      redirect '/success'  #change this to redirect directly to index page with user logged in
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])

    # binding.pry
    user_log_in(user)
    redirect '/success'
  end

  get '/success' do
    @user = current_user
    # binding.pry
    erb :'users/success'
  end


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
        # redirect '/account' #redirect to a user's list of tweets
      else
        redirect '/failure'
      end
    end
  end
end
