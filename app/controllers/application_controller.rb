require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
  end
  
  
   get '/' do
    # if logged_in?
    #   redirect to '/tweets'
    # else
      erb :index
    # end
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post "/signup" do
	   if params[:username].empty? || params[:password].empty? || params[:email].empty?
       redirect  '/signup'
     end
     
	   user = User.new(username: params["username"], email: params["email"], password: params["password"])
      if  user.save
        session[:user_id] = user.id
        redirect "/tweets"
      end
    end

   get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

   post "/login" do
     user = User.find_by(username: params[:username])
 
     if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
     else
      redirect "/login"
    end
  end
  
  get "/logout" do
   if logged_in?
    session.clear
      redirect to '/login'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets' do
    if logged_in?
      binding.pry
      @user = current_user
      @tweets = Tweet.all 
      erb :'tweets/tweets'
    else
      redirect 'users/login'
    end
  end
  
   get '/tweets/new' do
     if !logged_in?
       redirect 'users/login'
     else
      erb :"tweets/create_tweet"
    end
  end
  
   post '/tweets' do
    if logged_in?
       new_tweet = Tweet.new(content: params[:content], user: current_user)
    if new_tweet.save
      redirect  '/tweets'
    else
      redirect  '/tweets/new'
    end
  end
end

get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect  '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @user = current_user
      if @user.id == @tweet.user_id
        erb :'tweets/edit_tweet'
      else
        redirect  '/tweets'
      end
    else
      redirect  '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.update(content: params[:content])
      redirect  "/tweets/#{@tweet.id}"
    else
      redirect  "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @user = current_user
    if @user.id == @tweet.user_id
      @tweet.destroy
      redirect  '/tweets'
    else
      redirect  '/tweets'
    end
  end
  
  # post '/login' do
  #   #if User.username = User.find_by
  #     user = User.find_by(username: params[:username], password: params[:password])
  #     if user
  #     session[:user_id] = user.id
  #     redirect '/tweets/index'
  #   else 
  #     redirect '/failure'
  #   end
  # end

  # get '/tweets' do
  #   if Helpers.is_logged_in?(session)
  #     @user = Helpers.current_user(session)
  #     erb :'tweets/index'
  #   else
  #     erb :failure
  #   end
  # end

  # get "/failure" do
  #   erb :failure
  # end

  


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
     User.find_by_id(session[:user_id])
    end
  end

end  


