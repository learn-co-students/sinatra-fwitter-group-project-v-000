class UsersController < ApplicationController

    get '/login' do
    end

    get '/signup' do

        erb :"users/signup"
    end

    post '/signup' do

        if logged_in?
            redirect "/tweets"
        end

        user = User.new(username: params["user"]["name"], password: params["user"]["password"])

        if user.save
            login(params["user"]["name"], params["user"]["password"])
            redirect "/tweets"
        else
            redirect '/'
        end
    end

end
