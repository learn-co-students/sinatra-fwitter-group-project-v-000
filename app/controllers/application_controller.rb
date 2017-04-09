require './config/environment'
require 'pry'

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
  	if logged_in?
  		@tweets = Tweet.all
  		erb :'tweets/tweets'
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
  	if params[:content] != ""
	  	@tweet = Tweet.new(params)
	  	@tweet.user = current_user
	  	@tweet.save
	  	redirect '/tweets'
	  end
	  redirect '/tweets/new'
  end

  get '/signup' do
  	if !logged_in?
  		erb :'users/create_user'
  	else
  		redirect '/tweets'
  	end
  end

  post '/signup' do
	  	if params[:username] != "" && params[:email] != "" && params[:password] != ""
	  		@user = User.create(params)
	  		session[:id] = @user.id
	  		redirect '/tweets'
	  	end
  	redirect '/signup'
  end

  get '/login' do
  	if !logged_in?
  		erb :'users/login'
  	else
  		redirect '/tweets'
  	end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])
  	if @user
  		session[:id] = @user.id
  		redirect '/tweets'
  	end
  	redirect '/login'
  end

  get '/logout' do
  	if logged_in?
	    session.clear
	    redirect "/login"
	  else
	  	redirect '/'
	  end
  end

  get "/users/:slug" do
  	@user = User.find_by_slug(params[:slug])
  	erb :'users/tweets'
  end

  get '/tweets/:id' do
  	if logged_in?
	  	@tweet = Tweet.find_by_id(params[:id])
	  	erb :'tweets/show_tweet'
	  else
	  	redirect '/login'
	  end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
  		if @tweet.user_id == current_user.id
  			erb :'tweets/edit_tweet'
  		else
  			redirect '/tweets'
  		end
  	else
  		redirect '/login'
  	end

  end

  patch '/tweets/:id' do
  	@tweet = Tweet.find_by_id(params[:id])
  	if params[:content] != "" && @tweet.content != params[:content]	  	
	  	@tweet.content = params[:content]
	  	@tweet.save
	  	redirect "/tweets/#{@tweet.id}"
	  end
	  redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
  	@tweet = Tweet.find_by_id(params[:id])
  	if @tweet.user_id == current_user.id
  		@tweet.delete
  	end
  	redirect '/tweets'
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