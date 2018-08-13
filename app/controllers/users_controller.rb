class UsersController < ApplicationController

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect "/users/show/#{@user.id}"
    else
      redirect "/users/login"
    end
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.new(params)
    @user.save
    redirect "/users/login"
  end

  get '/show/:id' do
    @user = User.find(params[:id])
    if logged_in?
      @current_user = current_user
      erb '/users/show'
    else
      redirect "/users/login"
    end
  end

end
