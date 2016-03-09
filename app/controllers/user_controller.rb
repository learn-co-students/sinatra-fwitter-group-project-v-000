class UserController < ApplicationController

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
      session[:id] = user.id
      redirect '/tweets'
    else
      # erb :signup, locals: {message: "Registration invalid. Please try again"}
      redirect '/signup'
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
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/tweets'
    else
      erb :'users/login', locals: {message: "Login failed. Please try again"}
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
    erb :'users/user_tweets'
  end

end
