class UsersController < ApplicationController

  get "/signup" do
    erb :"/users/create_user"
  end

  post "/signup" do
    @user = User.create(params)
  end

  get "/login" do
    erb :"/users/login"
  end

  post "/login" do
    params #save in session hash
    #session << params
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  #helper_methods

  def current_user

  end

  def logged_in?

  end

end
