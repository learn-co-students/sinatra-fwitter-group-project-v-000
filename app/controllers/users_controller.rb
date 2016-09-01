class UsersController < ApplicationController

  ######## SIGN UP #########
  get '/signup' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new
    @user.username = params["username"]
    @user.email = params["email"]
    @user.password = params["password"]
    if @user.save
      login(params["username"], params["password"])
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  ######## LOG IN #########
  get '/login' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    puts params
    login(params[:username], params[:password])
    redirect to "/tweets"
  end

  ######## LOG OUT #########
  get '/logout' do
    logout!
    redirect to "/login"
  end

end

  # {"username"=>"coffee", "email"=>"coffee@coffee.com", "password"=>"coffee"}
