
class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect to '/login'
    end
  end

  post '/signup' do
    if logged_in?
      redirect '/tweets'
    elsif params[:username] == "" || params[:email] == "" || params[:password] == "" || User.user_exists?(params[:username])
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  post '/login' do
    user =  User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
