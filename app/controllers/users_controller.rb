class UsersController < ApplicationController

  get '/users/:slug' do
    @current_user = User.find_by_slug(params[:slug])

    erb :"/users/show"
  end

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect to "/tweets"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect to "/tweets"
    end
  end

  get '/logout' do
    if logged_in?
      logout!
      redirect '/login'
    else
      redirect to '/'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:login_error] = nil
      session[:user_id] = @user.id
    else
      flash[:message] = "Must have a username, email, and password to sign up, please try again!"
      redirect to "/signup"
    end
    redirect to "/tweets"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user.nil?
      flash[:message] = "Couldn't find an account with this username"
      redirect to "/login"
    else  @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

end
