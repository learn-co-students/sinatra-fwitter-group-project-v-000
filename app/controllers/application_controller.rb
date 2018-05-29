require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ftweet"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :"users/login"
  end
  post '/login' do
    user = User.find_by(:user_name => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/#{user.id}/tweets"
    else
      puts "*** Login Failed ***"
    end
  end

  get '/signup' do
    erb :"users/create_user"
  end
  post '/signup' do
    user = User.new(:user_name => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      redirect "/login"
    else
      redirect "/failure"
    end
  end

  get '/:id/tweets' do
    redirect "/failure" if !logged_in?
    @user = current_user()
    redirect "/failure" if !@user
    erb :"/tweets/tweets"
  end

  get '/failure' do
    erb :failure
  end
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
