class UsersController < ApplicationController

  get "/signup" do
    erb :'users/create_user'
  end

  post "/signup" do
    redirect "/failure" if params[:username] == ""
    user = User.new(:username => params[:username], :password => params[:password])
    if user.save
      redirect '/users/login'
    else
      redirect '/failure'
    end
  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect "/users/show"
      else
       redirect "/failure"
      end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

end
