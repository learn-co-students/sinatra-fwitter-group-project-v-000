require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "azerty"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
  	"Welcome to Fwitter"
  end

  get "/signup" do
  	erb :"users/new.html"
  end

  post "/register" do
    @user = User.create(params)
    session[:id] = @user.id
    redirect "/tweets"
  end


end