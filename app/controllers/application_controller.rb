require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :home
  end

  get "/login" do
    erb :"users/login"
  end

  get "/signup" do
    erb :"users/create_user"
  end

  post "/login" do
    @user = User.find_by(email: params[:inputemail])
    if @user && @user.authenticate(params[:inputpassword])
      session[:user_id] = @user.id
      redirect to "/tweets/tweets"
    else
      redirect to "/user/failure"
    end
  end

end
