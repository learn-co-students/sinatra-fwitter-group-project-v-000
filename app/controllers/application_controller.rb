require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
     enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
      @user = User.create(username: params[:username], email: params[:email], password_digest: params[:password])
      redirect "/login"
  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @user = user
      redirect "/user/index"
    else
      redirect "/failure"
    end
  end


  get "/logout" do
    session.clear
    redirect "/"

end