class UserController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
<<<<<<< HEAD
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
=======
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
>>>>>>> 36e95948dd71620eafc163333d4ad3d98c4c88a7
    end
  end

  get '/login' do
<<<<<<< HEAD
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
=======
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
>>>>>>> 36e95948dd71620eafc163333d4ad3d98c4c88a7
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
end
