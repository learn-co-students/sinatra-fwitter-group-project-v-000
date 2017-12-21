require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/tweets.new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    redirect '/tweets/#{@tweet.id}'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.create(params[:user])
    session[:id] = @user.id
    erb :'users/show'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    session[:id] = @user.id
    erb :'users/show'
  end

  get '/logout' do
    session.clear
  end

end
