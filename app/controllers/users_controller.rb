class UsersController < ApplicationController

    get '/users' do
        erb :'/users/login'
    end

    get '/users/new' do
        erb :'/users/create_user'
    end
end