class UsersController < ApplicationController

  get '/' do
    erb :'/users/home'
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    user = User.new(params)

    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/user/index"
  end

  get '/logout' do
    session.clear
    redirect :'/login'
  end
end
