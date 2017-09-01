require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  # HOME PAGE
  get '/' do
    erb :index
  end


  get '/tweets' do

   if logged_in?
     #binding.pry
    @tweets = Tweet.all
    erb :'tweets/tweets'
  else
    redirect to '/login'
  end
 end

  # CREATE TWEET
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
  #  binding.pry
    if params[:content] == ''
      redirect to 'tweets/new'
    else
      user = User.find_by_id(session[:id])
      @tweet = Tweet.create(content: params[:content], user_id: user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

#SHOW TWEET
 get '/tweets/:id' do
   #binding.pry
   if logged_in?
     @tweet = Tweet.find_by_id(params[:id])
     erb :'tweets/show_tweet'
   else
     redirect to '/login'
   end
 end

#EDIT TWEET
  get '/tweets/:id/edit' do
   if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:id]
       erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
   end

   patch '/tweets/:id' do
   if params[:content].empty?
     redirect to "/tweets/#{params[:id]}/edit"
   else
     @tweet = Tweet.find_by_id(params[:id])
     @tweet.content = params[:content]
     @tweet.save
     redirect to "/tweets/#{@tweet.id}"
   end
  end

#  DELETE TWEET
delete '/tweets/:id/delete' do
   if logged_in?
     @tweet = Tweet.find_by_id(params[:id])
     if @tweet.user_id == session[:id]
       @tweet.delete
       redirect to '/tweets'
     else
       redirect to '/tweets'
     end
   else
     redirect to '/login'
   end
 end

#User Logic

#SIGN UP
get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

post '/signup' do
   if params[:username] == "" || params[:email] == "" || params[:password] == ""
     redirect to '/signup'
   else
     @user = User.create(username: params[:username], email: params[:email], password: params[:password])
     @user.save
     session[:id] = @user.id
     redirect to '/tweets'
   end
 end

 #LOG IN
 get '/login' do
  #binding.pry
     if logged_in?
       redirect to '/tweets'
     else
       erb :'users/login'
     end
   end

   post '/login' do
    # binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      #binding.pry
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

 #LOG OUT
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect '/'
    end
  end

 #SHOW
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

 # HELPER METHODS
 		def logged_in?
 			!!session[:id]
 		end

 		def current_user
 			User.find(session[:id])
 		end


end
