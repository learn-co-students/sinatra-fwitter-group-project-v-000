require './config/environment'
require 'sinatra/base'
require 'rack-flash'
class ApplicationController < Sinatra::Base
#set :sessions, true
  configure do
    set :public_folder, 'public'
     set :views, 'app/views'
     enable :sessions
     use Rack::Flash
     set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !session[:user_id]
      #binding.pry
     erb :'/users/create_user'
   else
     redirect to '/tweets'
   end
  end

  post '/signup' do
      username = params["username"].size
      email = params["email"].size
      password = params["password"].size
      if username < 1 || email < 1 || password < 1
        flash[:message] = "Inputs may not be blank."
      redirect to "/signup"
      else
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
      end
    end

    get '/login' do
      if !session[:user_id]
        erb :'/users/login'
      else
        redirect to '/tweets'
      end
    end

    post '/login' do
      @user = User.find_by(:username => params[:username])
      #user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
    # if user && user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:message] = "You have signed in successfully."
        redirect to '/tweets'
      else
        flash[:message] = "Invalid username or password. Please try again."
        redirect to '/login'
      end
    end

    get '/logout' do
      session.clear
      redirect to '/login'
    end

    get '/tweets' do
       if !session[:user_id]
         redirect to '/login'
       else
         @user = User.find(session[:user_id])
         @tweets = Tweet.all
         erb :'/tweets/tweets'
       end
     end

    get '/users/:slug' do
         @user = User.find_by_slug(params[:slug])
         @tweets = @user.tweets
         erb :'users/show'
    end

   get '/tweets/new' do
     if !session[:user_id]
       flash[:message] = "You must be logged in to create a tweet."
       redirect to '/login'
     else
       erb :'/tweets/create_tweet'
     end
   end

    post '/tweets' do
          if params["content"].empty?
            #binding.pry
            redirect to "/tweets/new"
          else
              @tweet = Tweet.create(:content => params["content"], :user_id =>session[:user_id])
              @tweet.save
              flash[:message] = "Successfully created tweet."
          end
    end

    get '/tweets/:id'do
      if session[:user_id]
        #binding.pry #find a single tweet from :id
        @tweet = Tweet.find_by(params[:id])
        erb :'/tweets/show_tweet'
      else
        flash[:message] = "You must be logged in to view a tweet."
        redirect to '/login'
      end
    end

    get '/tweets/:id/edit' do  #load edit form
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet'
    end

    patch '/tweets/:id' do #edit action
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id/delete' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect to '/tweets'
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
