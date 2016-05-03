class UserController < ApplicationController

  get '/login' do
    if is_logged_in
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by(username: params[:slug])

    erb :'/tweets/tweets'
  end

  get '/signup' do
    if is_logged_in
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
     # binding.pry
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    #binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    #clear session
    if is_logged_in && current_user
      #binding.pry
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end

end