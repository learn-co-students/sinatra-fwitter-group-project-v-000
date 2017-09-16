require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :session unless test?
    set :session_secret, "secret"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if !Helpers.logged_in?(session)
      erb :signup
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect "/signup"
    else
      @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get "/tweets" do
    @user = User.find(session[:user_id])
    erb :'tweets/index' #twitter index page where user must be logged in
  end

  get "/login" do
    if !Helpers.logged_in?(session)
      erb :login
    end
  end

  post "/login" do
    @user = User.find_by_username(params[:username])
    if @user.nil?
      erb :error
    else
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

end
