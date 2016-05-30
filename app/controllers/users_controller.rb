class UsersController < ApplicationController
  get '/signup' do
    unless is_logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.username == "" || @user.username == nil
      flash[:message] = "You must enter a username."
      redirect '/signup'
    elsif @user.email == "" || @user.email == nil
      flash[:message] = "You must enter an email."
      redirect '/signup'
    elsif @user.password == "" || @user.password == nil
      flash[:message] = "You must enter a password."
      redirect '/signup'
    else
      @user.save
    end
    session[:user_id] = @user.id
    redirect'/tweets'
  end

  get '/login' do
    unless is_logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user != nil && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end
