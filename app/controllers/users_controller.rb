class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params.all? {|key, value| value != ""}
      user = User.new(params)
      user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
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

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end



end
