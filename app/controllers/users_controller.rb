class UsersController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user =User.find_by(username: session[:username])
      erb :"/tweets/index"
    else
      redirect "/login"
    end
  end

end
