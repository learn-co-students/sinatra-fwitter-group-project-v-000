class UsersController < ApplicationController

    get '/login' do

        if logged_in?
            redirect "/tweets"
        end

        erb :"users/login"
    end

    post '/login' do
        login(params["username"], params["password"])
        redirect "/tweets"
    end

    get '/logout' do
        session.clear
        redirect "/login"
    end

    get '/signup' do

        if logged_in?
            redirect "/tweets"
        end

        erb :"users/signup"
    end

    post '/signup' do

        @user = User.new(username: params["username"], email: params["email"], password: params["password"])

        if @user.save
            login(params["username"], params["password"])
            redirect "/tweets"
        else
            redirect "/users/signup"
        end
    end

    get '/users/:slug' do

        @user = User.find_by_slug(params[:slug])

        erb :"users/show"
    end

end
