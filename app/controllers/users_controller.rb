# require_relative '../config/environment'

class UsersController < ApplicationController

    get '/signup' do
        # binding.pry
        if logged_in?
            redirect "/tweets"
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
        # binding.pry
        @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
        if params[:username].empty? || params[:password].empty? || params[:email].empty?
            redirect '/signup'
        else
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end


    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username], password: params[:password], email: params[:email])
        redirect '/tweets'
    end


    get '/tweets' do
        @tweets = Tweet.all
        erb :'tweets/tweet'
    end

end
