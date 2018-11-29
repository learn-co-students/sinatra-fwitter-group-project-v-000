class UsersController < ApplicationController

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
      flash[:message] = "Welcome!"
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
      flash[:errors] = "Account creation failure"
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/users/:slug' do
    redirect_if_not_logged_in
    @user = User.find(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end
