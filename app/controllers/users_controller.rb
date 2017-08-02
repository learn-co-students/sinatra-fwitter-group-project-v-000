require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    redirect to '/tweets' if logged_in? 

    erb :'/users/create_user'
  end

  get '/login' do
    redirect to '/tweets' if logged_in?

    erb :'users/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(slug)

    erb :'users/show'
  end

  get '/logout' do
    session.clear if logged_in?

    redirect to '/login'
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end

    flash[:notice] = "Invalid input. Please try again."
    redirect to '/signup'
  end

  post '/login' do
    if @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end

    flash[:notice] = "Invalid login. Please try again."
    redirect to '/login'
  end
  
end