class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


  post '/signup' do
    @user = User.new(params)
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    end
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
    # if logged_in?
    #   session.clear
    #   redirect to '/login'
    # else
    #   redirect to '/'
    # end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end


end
