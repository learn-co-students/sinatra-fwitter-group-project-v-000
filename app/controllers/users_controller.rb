class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect to "/tweets"
    end

  end

  post '/signup' do
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect to '/signup'
      else

        @user = User.new
        @user.username = params[:username]
        @user.email = params[:email]
        @user.password = params[:password]
        @user.save
        session[:user_id] = @user.id
        redirect "/tweets"
      end
  end

  get '/login' do
    # binding.pry
    if !logged_in?
      erb :'users/login'
    else
      redirect "/tweets"
    end
  end

  post '/login' do

    @user = User.find_by(username: params[:username])
    # binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      current_user

      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  get '/users/:slug' do
    # raise params.inspect
    @user = User.find_by_slug( params[:slug])
      erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

end
