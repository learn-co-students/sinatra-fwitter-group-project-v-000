class UserController < ApplicationController
  get '/signup' do
    redirect "/tweets" if logged_in?
    erb :'users/create_user'
  end

  post '/signup' do
    redirect "/signup" if params.has_value?("")
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect "/tweets"
  end

  get '/login' do
    redirect "/tweets" if logged_in?
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    end
    redirect "/login"
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
