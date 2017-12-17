require './config/environment'

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

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_users'
    end
  end

  get '/tweets' do

   if logged_in?
     @user = current_user
     erb :'/tweets/tweets'
   else
     redirect '/login'
   end
  end

  post '/signup' do
     @user = User.create(params)
     if !params[:email].empty? && !params[:username].empty? && !params[:password].empty? && @user.save
       session[:user_id] = @user.id
       redirect '/tweets'
     else
       redirect '/signup'
     end
   end

  get '/login' do
   if logged_in?
     redirect '/tweets'
   else
     erb :'/users/login'
   end
  end

  post '/login' do
   @user = User.find_by(:username => "becky567")
   if !!@user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
     redirect '/tweets'
   else
     '/login'
   end
  end

   get '/logout' do
     session.destroy
     redirect '/login'
   end

   get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     erb :'/users/show'
   end

  get '/tweets/new' do
     if logged_in?
       erb :'/tweets/create_tweet'
     else
       redirect '/login'
     end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = User.find(session[:user_id])
    if !params[:content].empty?
      @tweet = Tweet.create(params)
      @tweet.user_id = @user.id
      @tweet.save
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = User.find(params[:id])
      @tweet = @user.tweets.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      if !params[:content].empty?
        @tweet.content = params[:content]
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
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
