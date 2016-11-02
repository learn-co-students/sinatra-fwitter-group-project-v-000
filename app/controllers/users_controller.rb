class UsersController < ApplicationController

  get '/signup' do
    if logged_in
      redirect '/tweets'  
    else
      erb :'/users/new'
    end
  end

  post '/signup' do
    if logged_in
      redirect '/tweets'
    else
      @user = User.new(params)
      if @user.save
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/signup'
      end
    end
  end

  get '/login' do
    if logged_in
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
      if logged_in
        redirect '/tweets'
      else
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect '/tweets'
        else
          erb :'/users/error'
        end
      end
  end

  get '/logout' do
    if logged_in
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    if logged_in
      @this_user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect '/login'
    end
  end

end
