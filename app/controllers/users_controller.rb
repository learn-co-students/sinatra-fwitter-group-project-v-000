class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :"users/signup"
    end
  end

  post '/signup' do
    if params["username"].empty? || params["password"].empty? || params["email"].empty?
      redirect to '/signup'
    else
      user = User.new(params)
      if user.save
        session[:user_id] = user.id
        redirect to '/tweets'
      else
        redirect to '/signup'
      end
    end
  end

  get '/login' do
    if session[:user_id]
      redirect to '/tweets'
    end
    erb :"users/login"
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end