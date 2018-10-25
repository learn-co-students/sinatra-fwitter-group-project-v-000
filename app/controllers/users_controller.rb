class UsersController < ApplicationController

  get '/users/login' do
    erb :'/users/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    if logged_in?
      redirect to "/twitter/tweets"
    else
      erb :'/users/signup'
    end
  end

  get '/failure' do
    erb :'/users/failure'
  end

  get '/login' do
    if !logged_in?
        erb :'users/login'
      else
        redirect to "/tweets"
      end
  end

  post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to "/users/signup"
      else
          @user = User.create(params)
          session[:user_id] = @user.id
          redirect to "/tweets"
      end
    end

  post '/login' do
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
      else
      erb :'/users/failure'
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

end
