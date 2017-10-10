require './config/environment'
require 'rack-flash' #just here is fine.

class ApplicationController < Sinatra::Base

    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash

  get '/' do
    # binding.pry
    erb :homepage
  end

  get '/signup' do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      flash[:message] = "Please log out of your account first to sign up another account"
      # redirect "/#{@user.slug}/tweets"
      redirect "/tweets"
    else
      erb :signup
    end
  end

  get '/login' do
    # if session[:user_id]

    erb :login
  end

  post '/login' do
    # binding.pry
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # redirect "/#{@user.slug}/tweets"
      redirect "/tweets"
    else
      flash[:message] = "Incorrect username/password."
      redirect "/login"
    end

  end

  get '/tweets' do
    # binding.pry
    @user = User.find_by(session[:user_id])
    @tweets = Tweet.all
    erb :tweets
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
      # redirect "/#{@user.slug}/tweets"
      redirect "/tweets"
    end
  end



  get '/logout' do
    session.destroy
    # binding.pry
    redirect "/"
  end

  # get '/:slug/tweets' do
  #   @user = User.find_by_slug(params[:slug])
  #   erb :show
  # end






end
