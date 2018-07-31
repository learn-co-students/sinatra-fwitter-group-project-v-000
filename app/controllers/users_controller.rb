class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'users/show'
    else
      redirect "/"
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty?  || params[:password].empty?
      redirect "/signup"
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    session.destroy
    redirect '/login'
  end

end
