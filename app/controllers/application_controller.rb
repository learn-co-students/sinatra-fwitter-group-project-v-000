require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    "Welcome to Fwitter"
  end

  get "/signup" do
    erb :'/users/create_user'
  end

  post "/signup" do
    if params[:username] == "" || params[:username] == nil
      redirect to "/signup"
    elsif params[:email] == "" || params[:email] == nil
      redirect to "/signup"
    elsif params[:password] == "" || params[:password] == nil
      redirect to "/signup"
    else 
      @user = User.create(username: params["username"], password: params["password"], email: params["email"])
      @user.save
      redirect to "/tweets"
    end
    
  end 

end
