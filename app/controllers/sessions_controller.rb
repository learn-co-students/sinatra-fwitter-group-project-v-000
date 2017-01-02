class SessionsController < ApplicationController

  get '/login' do
    if !!session[:id]
      redirect to "/tweets"
    end
    erb :'users/login'
  end

  post '/login' do
    if params.has_value?("")
      redirect to "/login"
    else
      @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:id] = @user.id
          redirect to "/tweets"
        end
    end
  end

  get '/logout' do 
    session.clear
    redirect to "/login"
  end
end