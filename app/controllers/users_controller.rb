class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :"/users/create_user"
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :"/users/login"
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect '/signup'
    elsif User.find_by(:email => params[:email])
      redirect '/signin'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end

  post '/users' do
    @user = User.find_by(:username => params[:username], :password => params[:password])
    session[:id] = @user.id
    redirect '/tweets'
  end


end
