class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :"/users/create_user"
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username], :password => params[:password])
    session[:id] = @user.id
    redirect to '/tweets'
  end



  get '/logout' do
    if !session[:session_id].empty?
      session.clear
      redirect to '/login'
    end
  end

end
