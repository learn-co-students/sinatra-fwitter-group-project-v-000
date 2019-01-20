class UsersController < ApplicationController

  get '/signup' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    #binding.pry
    if !params.has_value?("")
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end
end
