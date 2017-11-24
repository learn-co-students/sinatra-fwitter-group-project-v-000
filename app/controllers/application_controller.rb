require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  get '/login' do
    erb :'users/login'
  end

  get '/logout' do
    erb :index
  end

  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/tweets/new' do

    erb :"tweet/create_tweet"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params['id'])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params['id'])
    erb :"tweet/edit_tweet"
  end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    user.save
    binding.pry
    if user(:username) != nil && user(:password) != nil && user(:email) != nil &&
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end

  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      redirect "/"
    end
  end

  post '/tweets' do
    redirect to "tweets/show"
  end

  post '/tweets/:id'do
    @tweet = Tweet.find_by(id: params['id'])
    redirect to "tweets/show"
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
