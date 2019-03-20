require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty?
      redirect to '/signup'
    else
      unless User.find_by_username(params[:username])
        @user = User.new(params)
        if @user.save
          session[:user_id] = @user.id
          redirect to '/tweets'
        else
          redirect to '/signup'
        end
      else
        redirect to '/signup'
      end
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Username or password does not match, try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end



end
