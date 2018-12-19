class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    elsif User.find_by(username: params[:username])
      @user = User.find_by(username: params[:username])
      redirect to '/login'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if params[:username] == "" || params[:password] == ""
      redirect to '/login'
    elsif @user
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
    redirect to '/tweets'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    end
    redirect "/"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'/users/show'
  end
end
