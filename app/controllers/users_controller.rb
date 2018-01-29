class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params.all? {|key, value| value != ""}
      user = User.new(params)
      user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    erb :'users/login'
  end




end
