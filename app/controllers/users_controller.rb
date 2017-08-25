class UsersController < ApplicationController
  get '/signup' do
    if session[:user_id]
      redirect :"/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect :"/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :"/tweets"
    else
      redirect 'login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/tweets/show_tweet"
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

end
