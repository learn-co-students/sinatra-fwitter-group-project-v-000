class SessionController < ApplicationController

  get "/login" do
    @flash_message = session[:flash] if session[:flash]
    session[:flash] = nil
    if UserHelper.logged_in?(session)
      redirect "/tweets"
    else
      erb :'/sessions/login'
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/tweets"
    else
      session[:flash] = "Invalid username and/or password"
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  post "/logout" do
    session.clear
    erb :'/sessions/logout'
  end

end
