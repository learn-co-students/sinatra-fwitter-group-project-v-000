require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["password"].empty? && !params["email"].empty?
      @user = User.create(username: params["username"], password: params["password"], email: params["email"])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    if User.find_by(username: params[:username], password: params[:password])
      @user = User.find_by(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  get '/tweets/new' do
    binding.pry
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect to '/'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params["content"], user_id: current_user.id)
    redirect to '/tweets'
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :"/tweets/tweets"
    else
      redirect to '/'
    end
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
