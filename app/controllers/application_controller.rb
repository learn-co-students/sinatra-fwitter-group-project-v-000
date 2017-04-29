require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'views/index'
  end

  get '/tweets' do
    if logged_in?
       @tweets = Tweet.all
       erb :"views/tweets/tweets"
     else
       redirect to "/login"
     end    
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"views/users/user_tweets"
  end
  
  get "/signup" do
    if logged_in?
      redirect to '/tweets'
    else
      erb :"views/users/create_user"
    end  
  end

  post "/signup" do
    if !params[:username].blank? && !params[:email].blank? && !params[:password].blank?
      @user = User.create(username: params[:username], email: params[:email], password_digest: params[:password])
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get "/login" do
    if logged_in?
     redirect to "/tweets"
    else
      erb :'views/users/login'
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "users/#{user.slug}"
    else
      redirect "views/failure"
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end
  end
  
end