require 'pry'
class UsersController < ApplicationController
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :"/users/home"
  end

  get "/signup" do
    if logged_in?
      redirect("/tweets")
    else
      erb :'/users/signup'
    end
  end

  post "/signup" do
    @user = User.create(params)
    if @user.username == "" || @user.email == "" || @user.password == ""
      redirect('/signup')
    else
      session[:user_id] = @user.id
      redirect("/tweets")
    end
  end

  get '/login' do
    if logged_in?
      redirect('/tweets')
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect('/tweets')
    else
      redirect ('/login')
    end
  end

  get "/tweets" do
    if logged_in?
      @user = current_user
      erb :'/users/tweets'
    else
      redirect('/login')
    end
  end

  get '/logout' do
    if !logged_in?
      redirect ('/')
    else
      session.clear
      redirect('/login')
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect('/login')
    end
  end

  post "/tweets" do
    @tweet = Tweet.create(params)
    if @tweet.content == " " || @tweet.content == nil
      redirect('/tweets/new')
    else
      @tweet.user_id = current_user.id
      @tweet.save
      redirect('/tweets')
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])

      erb :'/tweets/show'
    else
      redirect('/login')
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id = current_user.id
        erb :'/tweets/edit'
      else
        redirect('/tweets')
      end
    else
      redirect('/login')
    end
  end

  post "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params)
    redirect('/tweets/#{@tweet.id}')
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id = current_user.id
        @tweet = Tweet.delete(params[:id])
        redirect('/tweets')
      else
        redirect('/tweets')
      end
    else
      redirect('/login')
    end
  end

  helpers do

    def logged_in?
      if session[:user_id]
        return self
      else
        return false
      end
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
