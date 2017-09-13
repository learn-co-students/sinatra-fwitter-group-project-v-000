require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect "/signup"
    else
      @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      @user.save
    end
  end

end
