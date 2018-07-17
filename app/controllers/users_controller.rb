class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/users/signup' do
    if !@logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/users/signup'
    else
      @user = User.create(params[:id])
      session[:user_id] == @user.id
      redirect 'tweets/tweets'
    end
  end

  get '/users/login' do
    if !logged_in?
      redirect '/users/login'
    else
      redirect '/tweets/tweets'
    end
  end

  post '/users/login' do
    user = User.create(params[:id])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets/tweets'
    else
      rediret '/users/signup'
    end
  end

  get '/users/logout' do
    if logged_in?
      session.destroy
      redirect '/users/login'
    else
    redirect '/'
    end
  end

end
