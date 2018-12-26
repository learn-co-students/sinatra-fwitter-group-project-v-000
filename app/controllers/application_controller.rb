require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
  end

  get "/" do
    "Welcome to Fwitter"
  end

  get "/signup" do
    if Helpers.current_user.is_logged_in?(session)
      redirect to "/tweets"
    else 
    erb :'/users/create_user'
    end 
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
      session[:id] = @user.id
      redirect to "/tweets"
    end
  end 

end
