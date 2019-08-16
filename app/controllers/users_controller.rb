class UsersController < ApplicationController

  register Sinatra::ActiveRecordExtension
configure do
  enable :sessions unless test?
  set :session_secret, "password_security"
end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    # binding.pry
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
     redirect "/signup"
   else
     @user = User.create(username: params[:username], email: params[:email], password: params[:password])

     @user.save
      session[:user_id] = @user.id
     redirect "/tweets"
   end
  end

  get '/tweets' do
      if @current_user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/logout' do

      session.clear
      redirect to '/login'

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
