class UsersController < ApplicationController

    get '/users' do
        erb :'/users/login'
    end

    get '/signup' do
        erb :'/users/create_user'
    end

    post '/users' do
        @user = User.new(params[:user])
        redirect '/'
    end
end