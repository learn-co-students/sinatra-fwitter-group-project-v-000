class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to("/tweets")
    else
      erb :'users/create_user'
    end
  end


  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to("/signup")
    else
      @user = User.create(params)
      @user.save
      session[:user_id] = @user.id
    end

    redirect to("/tweets")
  end


  get '/login' do
    #binding.pry
    if logged_in?
      redirect to("/tweets")
    end

    erb :'users/login'
  end


  post '/login' do
    #binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to("/tweets")
    else
      redirect to("/login")
    end

  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to("/login")
    else
      redirect to("/")
    end
  end

  get '/users/:slug' do
    #binding.pry
    @user = User.find_by_slug(params[:slug])
    session[:user_id] = @user.id
    #binding.pry
    erb :'tweets/tweets'
  end

end
