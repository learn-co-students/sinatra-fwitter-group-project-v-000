class UsersController < ApplicationController
  get '/signup' do
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    new_user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if new_user.save
      session[:user_id] = new_user[:id]
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = user.find_by_slug(params[:slug])
    if session[:user_id] == @user.id
      erb :'users/show'
    else
      redirect to '/login'
    end
  end
end
