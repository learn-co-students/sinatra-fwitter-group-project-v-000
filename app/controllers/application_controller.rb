require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  
  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "its_a_secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !is_logged_in
      erb :'registrations/signup'
    else
      redirect '/tweets'
    end 
  end

  post '/signup' do
    if params[:username] != '' && params[:password] != '' && params[:email] != ''
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:id] = @user.id
      redirect '/tweets'
    else 
      redirect '/signup'
    end
  end

  get '/tweets' do
    if is_logged_in
      @user = current_user
      @tweets = Tweet.all 
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end


  get '/login' do
    if !is_logged_in
      erb :'sessions/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end 
  end

  get '/tweets/new' do
    if is_logged_in
      erb :'tweets/create'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty? 
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end 
  end

  get '/tweets/:id' do
    if is_logged_in
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/:id/delete' do
    @tweet = Tweet.find(params[:id]) 
    if is_logged_in && @tweet.user_id == current_user.id
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/index'
  end

  helpers do
    def is_logged_in
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

  get '/logout' do
    if is_logged_in
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end




end