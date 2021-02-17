class UsersController < ApplicationController

    get "/signup" do
        erb :"users/signup"
    end

    post "/signup" do
        @user = User.new(params)
        if @user.save
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

end
