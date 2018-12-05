class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    #binding.pry
    erb :'users/show'
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
     redirect :"/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome, #{@user.username}!"
      redirect '/tweets'
    else
      flash[:errors] = "Your credentials were invalid.  Please sign up or try again."
      redirect '/signup'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:error] = "Account creation failure"
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    redirect_if_not_logged_in
    if session[:user_id] != nil
      session.destroy
      flash[:message] = "You have been logged out"
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
