require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    #set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end
# HOME PAGE
  get '/' do
    erb :index
  end
# SIGN UP
  get '/signup' do
    if session[:user_id] != nil
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if !!@user.username && !!@user.email && !!@user.password && @user.username != "" && @user.email != "" && @user.password != ""
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets/index'
    else
      redirect '/signup'
    end
  end
# LOG IN
  get '/login' do
    if session[:user_id] != nil
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by username: params["username"]
    @user.slug = @user.username
    session[:user_id] = @user.id
    redirect '/tweets'
  end

# LOG OUT
  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end
