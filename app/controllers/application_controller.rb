require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    if logged_in?
      redirect :'/tweets'
    else
      erb :index
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect :'/tweets'
    else
      redirect :'/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect :'/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    redirect :'/tweets'
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
      redirect :'/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(params)
      @tweet.update(user_id: current_user.id)
      redirect :'/tweets'
    else
      redirect :'/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect :'/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to:'/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == params[:id].to_i && !params[:content].empty? 
      @tweet.update(params)
      redirect :"/tweets/#{@tweet.id}"
    else
      redirect :"/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if session[:user_id] == params[:id].to_i
      Tweet.delete(params[:id])
      redirect :'/tweets'
    else
      redirect :"/tweets/#{params[:id]}"
    end
  end

  get '/logout' do
    session.clear
    redirect :'/login'
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
