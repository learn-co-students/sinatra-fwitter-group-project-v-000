class UsersController < ApplicationController

  #logging in is simply storing the user's ID in the session hash.
  #logging out is simply clearing the session hash.

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params) #creates a new user and persists it to the database (saves it)
      session[:user_id] = @user.id #logs in the user
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && (user.password == params[:password])
      session[:user_id] = user.id
      redirect '/tweets' #if user is found and password is authenticated, redirec to tweets index
    else
      redirect '/signup' #if the username or password don't exist, redirect to the sign up page
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login' #if user is logged out, redirect to /login
    else
      redirect '/tweets' #if use IS logged in, redirect to /tweets
    end
  end
end
