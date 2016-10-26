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
    if logged_in
      redirect '/tweets'
    else
      erb :'/application/root'
    end
  end

  get '/tweets/new' do
    if logged_in
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in
      @user = current_user
      
      if params[:content].length <= 140
        
        @tweet = Tweet.new(content: params[:content], user_id: @user.id)
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
        
      else
        redirect to "/tweets/new"
      end
      
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in
      @user = current_user
      @tweet = Tweet.find(params[:id])
      
      if @user.tweets.include?(@tweet)
        erb :'/tweets/edit'
      else
        redirect to "/tweets/#{@tweet.id}"
      end
      
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    if logged_in
      @user = current_user
      @tweet = Tweet.find(params[:id])
      
      if @user.tweets.include?(@tweet)
        @tweet.content = params[:content]
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/#{@tweet.id}/edit"
        end
      else
        redirect to "/tweets/#{@tweet.id}"
      end
      
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    if logged_in
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if @user.tweets.include?(@tweet)
        @tweet.destroy
        redirect to "/tweets"
      else
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end
  
  get '/signup' do
    if !session[:user_id]
      erb :'/users/new'
    else
      redirect('/tweets')
    end
  end
  
  post '/signup' do
    if logged_in
      redirect to '/tweets'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect('/signup')
      end
    end
  end
  
  get '/login' do
    if logged_in
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end
  
  post '/login' do
      if logged_in
        redirect to '/tweets'
      else  
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to '/tweets'
        else
          erb :'/users/error'
        end
      end
  end
  
  get '/logout' do
    if logged_in
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end
  
  get '/users/:slug' do
    if logged_in
      @current_user = current_user
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect '/login'
    end
  end
  
  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def logged_in
      !!current_user
    end
  end
end
