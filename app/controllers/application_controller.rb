require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fleet"
  end
  
  
  get '/' do
    erb :home
  end
  
  get '/signup' do
      redirect '/tweets' if logged_in?
      erb :'users/create_user'
  end
  
  post '/signup' do
    if !!User.new(username: params[:username], email: params[:email], password: params[:password]).save
        session[:user_id] = User.last.id
        redirect '/tweets' 
    else
        redirect '/signup'
    end
  end
  
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect :'/tweets'
    end
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets' do
    if logged_in?
      @all_tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/logout' do
    if logged_in?
      log_out
      redirect '/login'
    else
      redirect '/'
    end
  end
  
  get '/users/:slug' do
    @current_user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
  
  get '/tweets/new' do
    if logged_in?
      current_user
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params[:content] != "" 
      Tweet.create(content: params[:content], user_id: current_user.id)
    else
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:tweet_id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:tweet_id])
    else
      redirect '/login'
    end
    erb :'tweets/show_tweet'
  end
  
  get '/tweets/:tweet_id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:tweet_id])
    else
      redirect '/login'
    end
    erb :'/tweets/edit_tweet'
  end
  
  post '/tweets/:tweet_id' do
    if logged_in?
      redirect "tweets/#{params[:tweet_id]}/edit" if params[:content] == ""
      @tweet = Tweet.find_by_id(params[:tweet_id])
      @tweet.content = params[:content]
      @tweet.save
    else
      redirect '/login'
    end
    erb :'tweets/show_tweet'
  end
  
  post '/tweets/:tweet_id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:tweet_id])
      @tweet.delete if @current_user.id == @tweet.user.id
    else
      redirect '/login'
    end
    redirect '/tweets'
  end
  
  helpers do
      
      def logged_in?
          !!current_user
      end
      
      def log_out
          session.clear
      end
      
      def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end
      
  end
end  