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

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to :'/tweets'
    else
      redirect to :'/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to :'/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    redirect to :'/tweets'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to :'/login'
    end
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    @tweet.update(user_id: current_user.id)
    redirect to :'/tweets'
  end

  get '/logout' do
    session.clear
    redirect to :'/login'
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
