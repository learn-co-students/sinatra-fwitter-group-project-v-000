class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    user = User.new(params)
 
    if user.save
      session[:user_id] = user.id

      redirect '/tweets'
    else
      redirect '/users/signup'
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
    if user = User.find_by(username: params[:username]).authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    if @user = current_user
      @tweets = @user.tweets
  
      erb :'/users/show'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear

    redirect '/login'
  end
end