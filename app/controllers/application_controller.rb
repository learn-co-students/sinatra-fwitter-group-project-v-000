require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "blah"
  end
  
  get "/" do
    erb :index
  end

  get "/signup" do
    if logged_in?
      @user = User.find(session[:user_id])
      redirect '/tweets'
    else
      erb :signup
    end
  end

  post "/signup" do
    user = User.create(:username => params[:username],:email=>params[:email], :password=>params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      erb :signup
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :tweets
    else
      erb :login
    end
  end
  
  get "/login" do
    if logged_in?
      @user = User.find(session[:user_id])
      redirect '/tweets'
    else
      erb :login
    end
  end

  post "/login" do
    # binding.pry
    user = User.find_by(:username=>params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/failure'
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  #annoying chrome
  get "/favicon.ico" do
  end
end