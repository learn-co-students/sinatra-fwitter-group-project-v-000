require 'rack-flash'
require 'rack/flash/test' # => https://github.com/nakajima/rack-flash/issues/1
require 'pry'

class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      flash[:message] = "Please create an account"
      erb :'/users/new'
    end
  end


  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id

      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      flash[:message] = "Please login"
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else

      flash[:message] = "The account doesn't exist, please sign up"
      erb :'/users/new'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    if @user == current_user
      erb :'/users/show'
    else
      redirect to '/login'
    end
  end

end