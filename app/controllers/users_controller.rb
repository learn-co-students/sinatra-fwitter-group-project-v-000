class UsersController < ApplicationController

  get "/users/:id" do
    @user = User.find(params[:id])
    
    if logged_in?
      erb :"users/show"
    else
      redirect "/login"
    end
  end

end
