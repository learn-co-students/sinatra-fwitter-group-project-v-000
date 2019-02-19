class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])

      if user.save
        session[:user_id] = user.id
        redirect "/tweets/tweets" 
      else
        redirect "/signup"
      end
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets/tweets" # TODO: Render or redirect
    else
      redirect "/login"
    end
  end
end
