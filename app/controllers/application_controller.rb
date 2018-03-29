require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
  	erb :index
  end

  get '/tweets' do
  	if logged_in?
  		erb :'/tweets/tweets'	
 	else
	  	redirect '/login'
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
  	@tweet = Tweet.new(content: params[:content], user_id: session[:id])
  	@tweet.save

  	redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
  	if logged_in?
	  	@tweet = Tweet.find_by_id(params[:id])
	  	erb :'/tweets/show_tweet'
	 else
	  	redirect '/login'
  	end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
	  	@user = current_user
	  	@tweet = Tweet.find_by_id(params[:id])
	  	erb :'tweets/edit_tweet'
	  else
	  	redirect '/login'
  	end
  end

  patch '/tweets/:id' do
  	@tweet = Tweet.find_by_id(params[:id])
  	@tweet.update(content: params[:content])
  	@tweet.save
  	redirect "/tweets/#{@tweet.id}"
  end

  post '/tweets/:id/delete' do 
  	@tweet = Tweet.find_by_id(params[:id])
  	@tweet.delete
  	redirect "/tweets"
  end

  get '/signup' do
  	if logged_in?
  		redirect '/tweets'
  	else
  		erb :'/users/create_user'
  	end
  end

  post '/signup' do
  	if !params.value?("")
  		@user = User.create(params)
  		@user.save
  		session[:id] = @user.id
  		redirect "/tweets"
  	else
  		redirect '/signup'
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
  	if @user = User.find_by(username: params['username'], password: params['password'])
  		session[:id] = @user.id
  		redirect '/tweets'
  	else
  		redirect '/login'
  	end
  end

  get '/users/:slug' do
  	@user = current_user
  	erb :'/users/show'
  end

  get '/logout' do
  	session.clear
  	redirect '/login'
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