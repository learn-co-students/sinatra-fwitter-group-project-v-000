require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  
  	

    configure do
     set :public_folder, 'public'
     set :views, 'app/views'
     enable :sessions
     set :session_secret, "secret"
    end

  get '/' do
  	erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else 
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    #no user name- so sign up. if username is empty throw error
    #no email- no sign up. if email is empty throw error
    #no password - no sign up. If password is empty throw error
    #if someone is already logged in, redirect to twitter index.
    end
  end

  get '/login' do
    #displays the form if user isn't already logged in
    if logged_in?
       redirect to "/tweets"
     else
       erb :'/users/login'
    end
  end

  post '/login' do
  	@user = User.find_by(username: params["username"])
    #binding.pry
  	if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
  	else
  		redirect to '/login'
  	end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
    #binding.pry
  end

  get '/tweets' do
    if logged_in? #&& current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in? && current_user
      erb :'/tweets/create_tweet'
    else 
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    #binding.pry
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show_tweet'
      else
        redirect to '/login'
      end
  end

  post '/tweets' do
    #@user = User.find_by(session[:user_id])
    if params["content"] == ""
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(content: params["content"])
      current_user.tweets << @tweet
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? 
      @tweet = Tweet.find_by(params[:id])
        if @tweet.user_id == current_user.id
          erb :'/tweets/edit_tweet'
        else
          redirect to '/tweets'
        end
      else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if params["content"] == ""
      redirect to "/tweets/#{@tweet.id}/edit"
    else
     @tweet.content = (params["content"])
     @tweet.save
     redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in? && current_user
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to 'tweets'
      end
    else
      redirect to '/login'
    end
  end
 


  helpers do
     def current_user
       if session[:user_id] != nil
        User.find_by_id(session[:user_id])
       end
     end
 
     def logged_in?
       !!current_user
     end
   end
end