class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do

    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      user.save
    end
    session[:user_id] = user.id
    redirect '/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    'This is the post /login route'
  end

end
