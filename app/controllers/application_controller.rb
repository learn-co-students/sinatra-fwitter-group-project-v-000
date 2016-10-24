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
    if session[:user_id]
      redirect to ('/tweets')
    else
      erb :'/application/root'
    end
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
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect('/login')
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
    if session[:user_id]
      redirect to '/tweets'
    else
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect('/signup')
      else
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save
          @user.save
          session[:user_id] = @user.id
          redirect to '/tweets'
        else
          erb :'/users/error'
        end
      end
    end
  end
  
  get '/login' do
    if session[:user_id]
      redirect '/tweets' 
    else
      erb :'/users/login'
    end
  end
  
  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        erb :'/users/error'
      end
  end
  
  get '/logout' do
    if session[:user_id]
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end
  
  helpers do
    def current_user
      User.find(session[:user_id])
    end
  
  end
end
