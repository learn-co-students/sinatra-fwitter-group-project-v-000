require './config/environment'
require './app/models/user'
# require 'rack-flash'

class ApplicationController < Sinatra::Base
  # use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :"index"
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  post "/login" do
     @user = User.find_by(username: params[:username])
     session[:user_id] = @user.id
     if @user && @user.authenticate(params[:password])
       redirect '/tweets'
     else
       redirect '/login'
     end
   end

   get '/logout' do
     if !logged_in?
       redirect '/'
     else
       logout!
       redirect '/login'
     end
   end

   get "/users/:slug" do
     @user = User.find_by(:username => params[:slug])
     erb :"/users/show"
   end

  get '/tweets' do
    @tweets = Tweet.all
    @user = User.find_by(:id => session[:user_id])

    if logged_in?
      erb :"/tweets/index"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :"/tweets/new"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @user = current_user
      @tweet = @user.tweets.find_by(:id => params[:id])
      if @tweet.user_id == @user.id
        erb :"/tweets/show_tweet"
      else redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets' do
     if params[:content] == ""
       redirect '/tweets/new'
     else
       @user = current_user
       if logged_in?
         @tweet = Tweet.new(:content => params[:content])
         @tweet.user_id = session[:user_id]
         @tweet.save
       else
         redirect '/'
       end
     end

     erb :"/tweets/show_tweet"
   end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = @user.tweets.find_by(:id => params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    @user = current_user
    @tweet = @user.tweets.find_by_id(params[:id])
    redirect "/tweets/#{@tweet.id}/edit"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect "/tweets"
    end
  end

  delete '/tweets/:id/delete' do
    @user = current_user

    if logged_in?
      if @user.tweets.find_by_id(params[:id])
        @tweet = @user.tweets.find_by_id(params[:id])
        if @tweet.user_id == @user.id
          @tweet.delete
          @user.save
          redirect '/tweets'
        end
      else
        redirect '/tweets'
      end
    end
  end

 helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logout!
      session.clear
    end
  end
end
