class UsersController < ApplicationController

    get "/signup" do
        if !session[:user_id]
            erb :"users/signup"
        else
            erb :"users/tweets"
        end
    end

    post "/signup" do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

end
