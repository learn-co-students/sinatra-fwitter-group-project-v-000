class UsersController < ApplicationController
  get '/signup' do
    if  logged_in?
      redirect "/tweets"
    else
    erb :"users/create_user"
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id #login

      redirect '/tweets'
    else
      redirect '/signup'
    end

  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/sessions/login"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      logout!
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

end
