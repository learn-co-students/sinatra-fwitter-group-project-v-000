class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to('/tweets')
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect to("/signup")
    end

    user= User.create(params)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to('/tweets')
    else
        redirect "/signup"
    end
    #erb :'/tweets/tweets'
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to('/tweets')
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to('/tweets')
      else
        redirect '/login'
      end
  end

  get '/logout' do
    #clear session hash
      session.clear
      redirect to '/login'
  end

  post '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    #binding.pry
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

#---------------------------------
end
