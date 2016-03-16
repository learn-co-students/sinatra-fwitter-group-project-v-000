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
    erb :"/users/create_user"
  end

  post "/signup" do 

    redirect to "/login" # if successful
  end

  get "/login" do 

  end

end