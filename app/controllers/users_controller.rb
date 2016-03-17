class UsersController < ApplicationController

get "/users/new" do
    erb :"users/create_user"
  end 

end