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
  	protect_data
  	@tweets = Tweet.all 
  	@user = current_user
  	erb :'tweets/tweets'
  end

  get '/tweets/new' do 
  	protect_data
  	erb :'tweets/create_tweet'
  end

  post '/tweets' do 
  	protect_data
    if params[:content] != ""
  	  tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect :"/tweets/#{tweet.id}"
    else
      redirect :"/tweets/new"
    end
  end

  get '/tweets/:id' do 
  	protect_data
  	@tweet = Tweet.find(params[:id])
  	@user = User.find(@tweet.user_id)

  	erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do 
    protect_data
    @tweet = Tweet.find(params[:id])

    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do 
    protect_data
    tweet = Tweet.find(params[:id])

    redirect :"/tweets/#{tweet.id}/edit" if params[:content] == ""
    tweet.update(content: params[:content]) 

    redirect :"/tweets/#{tweet.id}"
  end

  delete '/tweets/:id' do 
    protect_data
    Tweet.destroy(params[:id]) if current_user.tweets.detect{|tweet| tweet.id == params[:id].to_i}

    redirect :'/tweets'
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    @current_user = current_user.id
    erb :'users/show'
  end 

  get '/signup' do 
  	redirect :'/tweets' if logged_in? 
  	erb :'users/create_user'
  end

  post '/signup' do 
  	if (params[:username] != "") && (params[:email] != "") && (params[:password] != "") 
  		user = User.create(username: params[:username], password: params[:password])
      login(user)
  		redirect :'/tweets'
  	else 
  		redirect :'/signup'
  	end 	
  end

  get '/login' do 
  	redirect :'/tweets' if logged_in? 
  	erb :'users/login'
  end

  post '/login' do 
  	user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
  		login(user)
  		redirect :"/tweets"
    else 
    	redirect :"/login"
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

    def login(user)
      session[:user_id] = user.id
    end

    def protect_data
      redirect :'/login' if !logged_in?
    end

  end
end