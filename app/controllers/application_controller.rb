require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "azerty"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
  	erb :"home.html"
  end

  get "/signup" do
  	erb :"users/new.html"
  end

  get "/login" do
    erb :"sessions/new.html"
  end

  post "/register" do
    user = User.new(params)
    params.inspect
    if user.save
      session[:id] = user.id
      redirect "/tweets"
    else
      erb :"users/new.html"
    end
  end

  get "/tweets" do
    @tweets = Tweet.all
    erb :"tweets/index.html"
  end

  get "/tweets/new" do |variable|
    
  end

end