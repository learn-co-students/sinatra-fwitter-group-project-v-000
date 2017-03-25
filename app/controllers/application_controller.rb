require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/tweets' do
    @user = current_user if logged_in?
    logged_in? ? (erb :'tweets/tweets') : (redirect to '/login')
  end

  get '/users/:slug' do
    @tweets = Tweet.where(user_id: User.find_by_slug(params[:slug]).id)
    erb :'tweets/show_tweet'
  end

  get '/signup' do
    !logged_in? ? (erb :'users/create_user') : (redirect to '/tweets')
  end

  post '/signup' do
    if !params.values.any? {|value| value.empty?}
      user = User.create(params)
      session[:id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    !logged_in? ? (erb :'users/login') : (redirect to '/tweets')
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if !!@user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
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
