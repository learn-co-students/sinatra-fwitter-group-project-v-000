require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Account created succesfully."
      redirect to '/tweets'
    else
      flash[:message] = "Sign up failed. Please make sure to fill out all fields."
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:message] = "Successfully logged in"
        redirect to '/tweets'
    else
      flash[:message] = "Login failed. Please try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      flash[:message] = "Successfully logged out."
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
