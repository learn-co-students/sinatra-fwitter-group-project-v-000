require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  get '/' do
    erb :index
  end

# users
  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if !params[:user][:user_name].empty? && !params[:user][:email].empty? && !params[:user][:password].empty?
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    binding.pry
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect 'login'
    else
      redirect '/'
    end
  end

# tweets
  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      erb :'users/login'
    end
  end

end
