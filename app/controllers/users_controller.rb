class UsersController < ApplicationController

    get '/login' do
        erb :'/users/login'
    end

    get '/signup' do
        erb :'/users/create_user'
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == "" || params[:email] == ""
            redirect "/signup"
        else
            User.create(username: params[:username], email: params[:email], password: params[:password])
            redirect "/tweets"
        end
    end

    get '/failure' do
        redirect '/'
    end
end