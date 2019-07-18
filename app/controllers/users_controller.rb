class UsersController < ApplicationController

  get "/signup" do
      erb :"users/create_user"
  end

  post "/signup" do
    if params[:username].blank? || params[:email].blank?
      redirect "/signup" if session
    elsif params[:password].blank?
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id]
      redirect "/tweets"
    end
  end
end
