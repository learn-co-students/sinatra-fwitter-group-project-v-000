class UsersController < ApplicationController
  
  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    redirect '/signup' if params[:username].empty? || params[:email].empty? || params[:password].empty?

    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id

    redirect "/tweets"
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear if logged_in?
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
