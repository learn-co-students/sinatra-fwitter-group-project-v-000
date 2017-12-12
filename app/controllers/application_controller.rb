require './config/environment'
require "./app/models/user"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    # binding.pry
    user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if params["username"] != "" && params["email"] != ""
      if user.save
        session[:user_id] = user.id
  			redirect :"tweets/tweets"
      end
    end
  end

end
