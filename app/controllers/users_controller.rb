class UsersController < ApplicationController

    get '/login' do
    end

    get '/signup' do

        erb :"users/signup"
    end

    post '/signup' do

        # if logged_in?
        #     redirect "/tweets"
        # end

        @user = User.new(username: params["username"], email: params["email"], password: params["password"])

        if @user.save
            login(params["username"], params["email"], params["password"])
            redirect "/tweets"
        else
            redirect "/users/signup"
        end
    end

end
