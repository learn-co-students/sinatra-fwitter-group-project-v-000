require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/login" do
    if logged_in? == true
      redirect "/"
    else
    erb :'/users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/signup" do
    erb :'/users/create_user'
  end

  helpers do
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
end

end
