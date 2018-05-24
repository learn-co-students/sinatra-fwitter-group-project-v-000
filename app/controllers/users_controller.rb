class UsersController < ApplicationController

  get '/signup' do
    redirect "/tweets" if logged_in?
    erb :'users/create_user'
  end

  get '/login' do
    redirect "/tweets" if logged_in?
    erb :'users/login'
  end

  get '/logout', :auth => :logged_in? do
    session.clear
    redirect "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])

    redirect "/signup" if !@user.valid?

    session[:user_id] = @user.id
    redirect "/tweets"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
