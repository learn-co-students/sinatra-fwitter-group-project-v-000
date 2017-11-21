class UsersController < ApplicationController

  get '/signup'do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username]=="" || params[:password]=="" || params[:email]==""
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = user_id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/login'
    end
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
