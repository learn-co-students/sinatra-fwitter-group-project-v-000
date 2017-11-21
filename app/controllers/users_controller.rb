class UsersController < ApplicationController

  get '/signup'do
    @session = session
    erb :'users/create_user'
  end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password])
    if user.save && user.username != ""
      redirect '/login'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    @session = session
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end
