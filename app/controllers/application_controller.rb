require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "allyson_fwitter"
  end

  get "/" do
    erb :home
  end

  get "/signup" do
    if logged_in?
      redirect to "/tweets"
    else
      erb :"registrations/signup"
    end
  end

  post "/signup" do
    user = User.new(params)

    if user.save
      redirect to "/tweets"
    else
      redirect to "/signup"
    end

  end

  get "/login" do
    erb :"sessions/login"
  end

  post "/login" do
    redirect "/tweets"
  end

  get "/logout" do
		session.clear
		redirect "/"
	end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

end
