class UserController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  get '/login' do
    if Helpers.current_user(session)
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
      @user = User.create(username:params["username"], email: params["email"], password_digest: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/show'
  end
end
