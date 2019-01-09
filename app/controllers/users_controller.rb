class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id] == nil
      erb :'users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username],email: params[:email], password: params[:password])

    if @user.save
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
      end
      redirect to '/tweets'
    else
      redirect to '/users/signup'
    end

  end

  get '/login' do
    if session[:user_id] == nil
      erb :'users/login'
    else
      @user = User.find_by(username: params[:username])
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/users/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'tweets/show_tweet'
  end

  get "/logout" do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
