class UsersController < ApplicationController

  ######## SIGN UP #########
  get '/signup' do
    erb :'/users/create_user'
  end

  # {"username"=>"coffee", "email"=>"coffee@coffee.com", "password"=>"coffee"}

  post '/signup' do
    @user = User.new
    @user.username = params["username"]
    @user.email = params["email"]
    @user.password = params["password"]
    if @user.save
      login(params["username"], params["email"], params["password"])
      redirect to "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  ######## LOG IN #########
  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    redirect to "/tweets"
  end

  ######## LOG OUT #########
  get '/logout' do
    redirect to "/login"
  end

end
