class UsersController < ApplicationController

    get "/signup" do
        erb :"users/signup"
    end

    post "/signup" do
        @user = User.create(params)
        redirect "/tweets"
    end

end
