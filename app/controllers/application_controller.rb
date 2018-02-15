require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base

  helpers do
   def logged_in?
     !!session[:user_id]
   end

   def current_user
     @users = User.find(session[:user_id])
   end
 end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end


  get '/' do
    erb :index
  end

  get '/login' do
     if logged_in?
       redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"], password: params["password"])

    if @user
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/signup' do

    if logged_in?
      redirect to'/tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params["username"], password: params["password"], email: params["email"] )
    @user.save
    if @user.username != "" && @user.password != "" && @user.email != ""
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
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

  get '/user/:slug' do
     @user = User.find_by(params[:slug])
     erb :'/users/show'
  end

  get '/tweets' do

    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.new(params)
      @tweet.user = current_user
      if @tweet.save
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
    else
      redirect "/login"
    end

  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        @tweet.save
      end
    end
    redirect "/tweets"
  end


end


#rspec ./spec/controllers/application_controller_spec.rb --fail-fast
