class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :"users/signup"
    end
  end

  post '/signup' do
    if params["username"].empty? || params["password"].empty? || params["email"].empty?
      redirect to '/signup'
    else
      user = User.new(params)
      if user.save
        session[:user_id] = user.id
        redirect to '/tweets'
      else
        redirect to '/signup'
      end
    end
  end

  get "/users/:slug" do
      @user_tweets = User.find_by_slug(params[:slug])
      erb :"users/tweets"
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :"users/login"
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end