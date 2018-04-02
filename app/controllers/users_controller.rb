class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    # check if a user with this user_id actually exists
    # if so, set the session
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      erb :'users/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end


end
