require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/tweets' do
    if is_logged_in?
    erb :'tweets/tweets'
  else
    redirect '/login'
  end
  end

  get '/signup' do
    if is_logged_in?
      redirect 'tweets/tweets'
    else
      erb :'/user/create_user'
    end
  end

  post '/signup' do
    if (params[:username] == "" || params[:email]=="" || params[:password] =="")
     redirect '/signup'
   else
     @user = User.find_or_create_by(username: params[:username])
     @user.email = params[:email];
     @user.password = params[:password]
     session[:id] = @user.id
     @user.save
    redirect 'tweets/tweets'
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'user/login'
    else
    redirect 'tweets/tweets'
    end
  end

  post '/login' do
   user = User.find_by(username: params["username"])
   if user && user.authenticate(params["password"])
     session[:id] = user.id
     redirect '/tweets'
   else
     redirect '/login'
   end
 end

  get '/logout' do
    if is_logged_in?
      session.destroy

      redirect '/login'
    else
      redirect '/'
    end
  end



  helpers do
    def is_logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end



end
