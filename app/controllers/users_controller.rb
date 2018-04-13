class UsersController < ApplicationController

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect "/failure"
    else
      User.create(username: params[:username], password: params[:password])
      redirect "/login"
    end
  end
end
