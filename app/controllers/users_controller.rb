class UsersController < ApplicationController

  get "/signup" do
    erb :"users/create_user"
  end

  post "/signup" do
    @user = User.create(params)
  end



end
