require 'rack-flash'
require 'rack/flash/test' # => https://github.com/nakajima/rack-flash/issues/1
require 'pry'
class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do

    if !logged_in?
      flash[:message] = "Please create an account"
      erb :'/users/new'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.create(params[:user])
    session[:user_id] = @user.id
    @user.save

    redirect to '/tweets'
  end

  get '/login' do
    if !logged_in?
      flash[:message] = "Please login"
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user != current_user
      redirect to '/login'
    end

    erb :'/users/show'
  end

end
