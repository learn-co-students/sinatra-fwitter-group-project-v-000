class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
    erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to "/signup"
    else
      @user = User.create(params)
      @user.save
      session[:id] = @user.id
      redirect to "/tweets"
    end 
  end

  get '/login' do
    if !session[:id] 
      erb :'users/login'
    else
      redirect to "/tweets"
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/logout' do 
    if session[:id] != nil
      session.destroy
      redirect to "/login"
    else
      redirect to '/'
    end
  end

end