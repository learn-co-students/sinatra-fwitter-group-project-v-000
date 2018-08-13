class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
    redirect to '/signup'
    else
      user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end

  get '/sessions/login' do
    erb :'/users/login'
  end

  post '/sessions/login' do
    @user = User.find_by(username: params["username"], password: params["password"])
    session[:id] = @user.id
    redirect to '/tweets'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

end
