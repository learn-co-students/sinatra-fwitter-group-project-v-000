class UsersController < ApplicationController

  get '/signup' do
    redirect to '/tweets' if is_logged_in?(session)
    erb :'users/create_user'
  end

  post '/signup' do
    redirect to '/signup' if params[:username].empty? || params[:email].empty? || params[:password].empty?
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect to '/tweets'
  end

  get '/login' do
    redirect to '/tweets' if is_logged_in?(session)
    erb :'users/login'
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
    session[:user_id] = nil
    redirect '/login'
  end

  get '/users/:slug' do
    @user = user.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
