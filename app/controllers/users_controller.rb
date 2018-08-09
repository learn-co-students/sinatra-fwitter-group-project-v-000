class UsersController < ApplicationController


  get '/users/signup' do
    erb :'users/signup'
  end

  get '/users/login' do
    erb :'/users/login'
  end

  post '/users/signup' do
    @user = User.create(params[:user])

    redirect '/users/login'
  end

  post '/users/login' do
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/users/failure'
    end
  end

  get '/users/failure' do
    erb :'users/failure'
  end


  get '/users/logout' do
    session.clear

    redirect '/'
  end

end
