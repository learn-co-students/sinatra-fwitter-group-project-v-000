require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if is_logged_in?
      redirect to "/tweets"
    else
      erb :'registrations/signup'
    end
  end

  post "/signup" do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to "/signup"
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save
        session[:id] = user.id
        redirect to "/tweets"
      else
        redirect to "/signup"
      end
    end
  end

  get "/login" do
    if is_logged_in?
      redirect to "/tweets"
    else
      erb :'sessions/login'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect to "/tweets"
    else
      redirect to "/failure"
    end
  end

  get "/logout" do
    if is_logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  

  get "/failure" do
    erb :failure
  end



  helpers do
    def is_logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end



end
