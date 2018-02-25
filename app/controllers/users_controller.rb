class UsersController < ApplicationController

  get '/signup' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end


  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end


  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end


  post '/login' do
  end


  get '/logout' do
  end


  get '/users/:slug' do
  end
end
