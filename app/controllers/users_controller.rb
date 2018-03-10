class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if User.create(params).valid?
      @user = User.create(params)
      session[:user_id] = @user.id
    else
      redirect "/signup"
    end
    redirect "/tweets"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    end
    erb :'users/login'
  end

  post '/login' do
    if @user = User.find_by(:username => params[:username]).try(:authenticate, params[:password])
      session[:user_id] = @user.id
    else
      redirect "/"
    end
    redirect "/tweets"
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect to "/"
    end
  end

end
