class UserController < ApplicationController

  get '/users' do
    @users = User.all

    erb :'/users/index'
  end

  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  post '/signup' do
    if !params.values.all?{|param| !param.empty?}
      redirect '/errors/signup'
    end

    if is_logged_in?
      redirect '/tweets'
    end

    if !!@user = User.find_by(email: params[:email])
      redirect '/login'
    end
    # binding.pry
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.save
    session[:id] = @user.id
    redirect '/tweets'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/errors/login'
    end
  end

end
