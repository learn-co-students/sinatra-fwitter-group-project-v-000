class UsersController < ApplicationController

  # configure do
  #   set :public_folder, 'public'
  #   set :views, 'app/views'
  #   enable :sessions
  #   # set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  #   # set :session_secret, SecureRandom.hex(64)
  # end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/user_tweets'
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    user = User.create(params) # have them create a new account
    # if the user saves assign session id to user id then redirect them to the tweets
    if user.save
      session[:id] = user.id
      redirect to '/tweets'
    else # otherwise
      redirect to '/signup' # redirect them to signup
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect to '/signup'
    end
  end

  # logout go here?
  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
