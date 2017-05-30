class UserController < ApplicationController
  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    end

    erb :'/users/signup'
  end

  get '/login' do
    erb :'/users/login'
  end

  get '/users/:username' do
    @user = User.find_by_slug(params[:username])

    erb :'users/show'
  end

  post '/users' do
    user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password]
    )

    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end
end
