# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "spicy pickle"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/signup'
    end
  end

  post '/signup' do
    if !params[:username].empty? and !params[:email].empty? and !params[:password].empty?
      user = User.create(params)
      session[:user_id] = user.id
    else
      redirect '/signup'
    end
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/failure'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  # get '/tweets' do
  #   if logged_in?
  #     erb :tweets
  #   else
  #     redirect '/login'
  #   end
  # end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :user
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
