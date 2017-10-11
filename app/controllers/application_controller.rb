require './config/environment'
require 'rack-flash' #just here is fine.

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash
  end

  get '/' do
    erb :homepage
  end

  get '/signup' do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      flash[:message] = "Please log out of your account first to sign up another account"
      redirect "/tweets"
    else
      erb :signup
    end
  end

  get '/login' do
    if session[:user_id]
      flash[:message] = "Already logged in."
      redirect "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      flash[:message] = "Incorrect username/password."
      redirect "/login"
    end

  end

  get '/tweets' do
    # @user = User.find_by(id: session[:user_id])
    if session[:user_id]
      @user = User.find(session[:user_id]) #safer error throwing
      @tweets = Tweet.all
      erb :tweets
    else
      flash[:message] = "Please log in or <a href='/signup'><u>sign up</u></a> to view tweets."
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :new
    else
      flash[:message] = "Please log in or <a href='/signup'><u>sign up</u></a> to post tweets."
      redirect "/login"
    end
  end

  post "/tweets" do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      @user = User.find(session[:user_id])
      redirect "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Please don't post a blank tweet."
      redirect "/tweets/new"
    end
  end

  get "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    erb :tweet
  end

  post '/signup' do
    if params[:username].empty?
      flash[:message] = "Please enter a valid username."
      redirect "/signup"
    elsif params[:email].empty?
      flash[:message] = "Please enter a valid email."
      redirect "/signup"
    elsif params[:password].empty?
      flash[:message] = "Please enter a valid password."
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end



  get '/logout' do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :show
  end








end
