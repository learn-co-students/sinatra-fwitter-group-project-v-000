require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  	set :session_secret, "secret"
  end


 #Home
  get '/' do 
  	erb :'index'
  end


#Sign Up
  get '/signup' do
  	if Helpers.is_logged_in?(session)
  		redirect '/tweets'
  	else
  		erb :'users/signup'
  	end
  end

  post '/signup' do 
  	@user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
  	@user.save
  	session[:id] = @user[:id]
  	if @user.save && !params[:username].empty? && !params[:email].empty?
  		redirect '/tweets'
  	else
  		redirect '/signup'
  	end
  end

#Log in
  get '/login' do
  	if Helpers.is_logged_in?(session)
  		redirect '/tweets'
  	else
		erb :'users/login'
	end
  end

  post '/login' do 
 	@user = User.find_by(:username => params[:username])
 	if @user && @user.authenticate(params[:password])
  		session[:id] = @user[:id]
		redirect '/tweets'
	else
		redirect '/login'
	end
  end

  #Log Out
  get '/logout' do 
  	session.clear
  	redirect '/login'
  end

  #Home Page - tweets feed
  get '/tweets' do
  	if Helpers.is_logged_in?(session)
  		@user = User.find_by_id(session[:id])
  		erb :'tweets/tweets'
  	else
  		redirect '/login'
  	end
  end

  #Show single user tweets
  get '/users/:slug' do 
  	@user = User.find_by_slug(params[:slug])
  	erb :'users/tweets'
  end

  #TWEETS
  #New
  get '/tweets/new' do 
  	if Helpers.is_logged_in?(session)
	  	@user = User.find_by_id(session[:id])
  		erb :'tweets/new'
  	else
  		redirect '/login'
  	end
  end

  post '/tweets/new' do 
  	if params[:content] != ""
  		@tweet = Tweet.create(:content => params[:content])
  		@user = User.find_by_id(session[:id])
  		@user.tweets << @tweet
  		redirect "/tweets/#{@tweet.id}"
  	else
  		redirect '/tweets/new'
  	end
  end	

  #Show
  get '/tweets/:id' do
  	if Helpers.is_logged_in?(session)
  		@tweet = Tweet.find_by(:id => params[:id])
  		erb :'tweets/show'
  	else
  		redirect '/login'
  	end
  end

  #Edit
  get '/tweets/:id/edit' do 
  	if Helpers.is_logged_in?(session)
  		@tweet = Tweet.find_by(:id => params[:id])
  		erb :'tweets/edit'
  	else
  		redirect '/login'
  	end
  end

  patch '/tweets/:id/edit' do
  	@tweet = Tweet.find_by(:id => params[:id])
    @user = User.find_by_id(session[:id])
    redirect "/tweets" if @user.id != @tweet.user_id
  	if params[:content] != ""
  		#binding.pry
  		@tweet.content = params[:content]
  		@tweet.save
  		redirect "/tweets/#{@tweet.id}"
  	else
  		redirect "tweets/#{@tweet.id}/edit"
  	end
  end

  #Delete
  delete '/tweets/:id/delete' do 
  	@user = User.find_by_id(session[:id])
  	@tweet = Tweet.find_by(:id => params[:id])
  	Tweet.delete(params[:id]) if @user.id == @tweet.user_id
  	redirect '/tweets'
  end




end
























