class SessionsController < ApplicationController

   get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] 
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end