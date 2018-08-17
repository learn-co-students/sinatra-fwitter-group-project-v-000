class UsersController < ApplicationController

    get '/' do
        authorize
        tweets = Tweet.order("created_at")
        if tweets.length <= 10
            @tweets= tweets.reverse
        else
            @tweets = tweet[tweets.length - 10, tweets.length].reverse
        end
        erb :"user/home"
    end 

    get '/users/:user/tweets' do
        @user = User.find_by_slug(params[:user])
        erb :"user/tweets"
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

end
