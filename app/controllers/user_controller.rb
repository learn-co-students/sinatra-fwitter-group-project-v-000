class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect "/tweets"
    else
        redirect "/users/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = @current_user
      erb :"users/show"
    else
      redirect "/login"
    end
  end

end
