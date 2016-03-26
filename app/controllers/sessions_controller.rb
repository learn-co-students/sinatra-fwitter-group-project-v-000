class SessionsController < ApplicationController

  get '/login' do
    if !!session[:id]
      redirect to "/tweets"
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:id] = @user.id
    redirect to "/tweets"
  end

  get '/logout' do 
    session.clear
    redirect to "/login"
  end
end