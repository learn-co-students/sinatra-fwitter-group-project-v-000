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
  	erb :'/tweets/tweets'
  end

  get '/tweets/new' do
  	erb :'/tweets/create_tweet'
  end

  post '/tweets' do
  	@tweet = Tweet.new(content: params[:content])
  	@tweet.save
  	redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
  	@tweet = Tweet.find_by_id(params[:id])
  	erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
  	@tweet = Tweet.find_by_id(params[:id])
  	erb :'tweets/edit_tweet'
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

  get '/users/signup' do
  	erb :'/users/create_user'
  end

  post '/users/signup' do
  	@user = User.create(params)
  	@user.save
  	session[:id] = @user.id
  	redirect "/tweets/new"
  end

  get '/users/login' do
  	erb :'/users/login'
  end

  post '/users' do
  	if @user = User.find_by(username: params['username'], password: params['password'])
  		session[:id] = @user.id
  		redirect '/tweets/new'
  	else
  		redirect '/users/login'
  	end
  end
end