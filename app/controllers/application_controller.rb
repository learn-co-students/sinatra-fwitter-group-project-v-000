require './config/environment'
require 'sinatra'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
  end

  get '/' do
    if logged_in?
      @user = User.find(current_user.id)
      redirect to "/users/#{user.slug}"
    else
      erb :index
  end
end


    get '/signup' do
        if logged_in?
          redirect to "/tweets"
else
        erb :'/users/create_user'
    end
end

    post '/signup' do
  if params[:username] == "" || params[:password] == "" || params[:email] == ""
    redirect to '/signup'
  else
      @user = User.create(params)
                @user.save
          session[:id] = @user.id
          redirect to "/tweets"
          end
  end

get '/login' do
  erb:'/users/login'
end

post '/login' do
  @user = User.find_by(username: params["email"], password: params["password"])
if user && user.authenticate(params[:password])
  session[:id] = @user.id
redirect to "/tweets"
else
  redirect to "/"
end
end

get '/logout' do
if logged_in?
  session[:id].clear
  redirect to '/login'
else
  redirect to '/'
end
end

def logged_in?
  !!session[:user_id]
end

def current_user
  User.find(session[:user_id])
end




end
