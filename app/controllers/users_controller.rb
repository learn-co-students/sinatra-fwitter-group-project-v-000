class UsersController < ApplicationController


  get '/signup' do
    # @user = User.find_by(id: session[:id])
    if logged_in?
      redirect to('/tweets')
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to('/tweets')
    else
      redirect to('/signup')
    end
  end

  get '/login' do
    @user = User.find_by(id: session[:user_id])
    if logged_in?
      redirect to ('/tweets')
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to('/tweets')
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
