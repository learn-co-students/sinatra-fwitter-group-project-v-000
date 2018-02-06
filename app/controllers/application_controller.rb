require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "GODisgreat"
  end

# HOME PAGE
  get '/' do
    erb :index
  end
#HELPERS
  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
# SIGN UP
  get '/signup' do
    if logged_in?
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
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end
# LOG IN
  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by username: params["username"]
    session[:user_id] = @user.id
    redirect '/tweets'
  end
# LOG OUT
  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end
