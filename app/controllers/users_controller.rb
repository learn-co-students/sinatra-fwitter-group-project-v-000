class UsersController < ApplicationController
  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    new_user = User.new(params)

    if params[:username].empty? || params[:email].empty? || !new_user.save
      redirect '/users/signup'
    else
      session[:user_id] = new_user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear

    redirect '/login'
  end
end