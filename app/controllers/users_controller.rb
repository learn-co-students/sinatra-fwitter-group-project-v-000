class UsersController < ApplicationController
  
  get '/signup' do
    if logged_in? then redirect "/tweets" end
    erb :"/users/create_user"
  end

  
  get '/logout' do
    session.clear
    redirect "/login"
  end

  
  post '/signup' do
    @user=User.create(params)
    if !@user.valid? then redirect "/signup" end
    session[:id] = @user.id
    redirect "/tweets"
  end

  get '/login' do
    if session[:id] then redirect "/tweets" end
    erb :"/users/login"
  end

  post '/login' do
    user= User.find_by(username: params[:username])
    # redirect "/tweets"
    if user && user.authenticate(params[:password])
      session[:id]=user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
