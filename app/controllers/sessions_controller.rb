class SessionsController < ApplicationController
  
  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(:email => params[:email])

    if @user && @user.authenticate(params[:password])
      session[:email] = @user.email
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    logout!
    redirect "/login"
  end
end