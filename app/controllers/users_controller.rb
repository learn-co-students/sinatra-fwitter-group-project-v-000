require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  # user signup action
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      flash[:message] = "Signup Failed! Please try again."
      redirect '/signup'
    end
  end

  # User Login action
  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      flash[:message] = "Mismatched Username or Password!!"
      redirect '/login'
    end
  end

  # User Logout
  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  # User Show action
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
end
