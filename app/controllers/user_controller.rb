class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @new_user = User.create(params)
      session[:user_id] = @new_user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @current_user = User.find_by(:username => params[:username])
    if @current_user && @current_user.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session[:user_id] = nil
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/#{@user.slug}"
  end

  get '/show' do
  end

end
