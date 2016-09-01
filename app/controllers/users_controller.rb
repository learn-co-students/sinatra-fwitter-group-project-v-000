class UsersController < ApplicationController

  ######## SIGN UP #########
  get '/signup' do
    #not sure 1st part works, need to to login page first
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
    # if session[:id] = user.id
    #   redirect to '/tweets'
    # else
    #   erb :'/users/create_user'
    # end
  end

  post '/signup' do
    @user = User.new
    @user.username = params["username"]
    @user.email = params["email"]
    @user.password = params["password"]
    if @user.save
      login(params["username"], params["email"], params["password"])
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  ######## LOG IN #########
  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    login(params[:username], params[:email], params[:password])
    redirect to "/tweets"
  end

  ######## LOG OUT #########
  get '/logout' do
    logout!
    redirect to "/login"
  end

end

  # {"username"=>"coffee", "email"=>"coffee@coffee.com", "password"=>"coffee"}
