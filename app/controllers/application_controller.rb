require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_application_secret"
  end

  get "/" do 
    erb :index
  end

  get "/signup" do 
    if logged_in?
      redirect to "/tweets"
    end
    erb :"/users/create_user"
  end

  post "/signup" do 
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id # log in the user after they sign up
      redirect to "/tweets"
    end
  end

  get "/login" do 

  end

end