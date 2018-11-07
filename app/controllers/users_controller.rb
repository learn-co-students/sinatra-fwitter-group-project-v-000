class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    if params.values.include?("")
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do

    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
