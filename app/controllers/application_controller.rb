require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "difficult_passphrase"
  end

  get '/' do
    erb :'/application/root'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    if !params[:content].empty? && params[:content].length <= 140
      @tweet = Tweet.create(content: params[:content])
    else
      redirect to "/tweets/new"
    end
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect('/')
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect to "/tweets"
  end
  
  get '/signup' do
    if !session[:user_id]
      erb :'/users/new'
    else
      redirect('/tweets')
    end
  end
  
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect('/signup')
    else
      @user = User.find_by(username: params[:username], email: params[:email], password: params[:password])
      if !@user
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      end
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end
  
  get '/login' do
    erb :'/users/login'
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      erb :'/users/error'
    end
  end
  
  get '/logout' do
    session.clear
    erb :'/users/logout'
  end
end
