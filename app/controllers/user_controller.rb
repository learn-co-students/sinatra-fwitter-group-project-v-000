class UserController < ApplicationController
  get '/signup' do
    redirect to('/tweets') if logged_in?
    haml :'users/create_user'
  end

  post '/signup' do
    redirect to('/signup') if params.has_value?('')

    params.delete(:submit)
    user = User.create(params)
    redirect to('/tweets')
  end

  get '/login' do
    redirect to('/tweets') if logged_in?
    haml :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    redirect to('/login') unless user && user.authenticate(params[:password])

    session[:user_id] = user.id
    flash[:message] = "Welcome, #{user.username}."
    redirect to('/tweets')
  end

  get '/logout' do
    session.clear
    redirect to('/login')
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    haml :'users/show'
  end
end
