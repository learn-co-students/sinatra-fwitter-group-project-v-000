class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username]).authenticate(params[:password])

    if @user
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      logout
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @tweets = User.find_by_slug(params[:slug]).tweets
    erb:'/users/show'
  end

end
