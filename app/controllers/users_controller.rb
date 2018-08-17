class UsersController < ApplicationController


  get '/signup' do
    if !session[:user_id]
      erb :'users/signup'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !params.values.include? ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'tweets/index'
    else
      redirect '/tweets/new'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user != nil
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end
end
