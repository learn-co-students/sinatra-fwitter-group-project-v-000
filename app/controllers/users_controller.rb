class UsersController < ApplicationController

  get '/signup' do

    erb :'users/create_user'
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
    binding.pry
    if logged_in?
      binding.pry
      redirect to("/tweets")
    end

    erb :'users/login'
  end


  post '/login' do
    binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
    binding.pry
      session[:user_id] = @user.id
      redirect to("/tweets")
    else
      redirect to("/login")
    end

  end


end
