require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #mine
    enable :sessions unless test?
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get "/signup" do
    if logged_in?
     redirect to '/tweets'
    end
    erb :'/users/create_user'
  end

  post "/signup" do
    if complete_form?
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ""
      @tweet.content = params["content"]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    end
    erb :'/users/login'
  end

  post "/login" do
    if complete_form?
      @user = User.find_by(username: params["username"])
    end

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
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
    erb :'tweets/tweets'
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      @tweet = Tweet.create(content: params["content"], user_id: session[:user_id])
    else
      redirect to '/tweets/new'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
    end
    redirect to '/tweets'
  end



  helpers do

    def complete_form?
      params["username"] != "" && params["password"] != "" && params["email"] != "" ? true : false
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end


end
