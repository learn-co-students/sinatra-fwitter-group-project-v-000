class UsersController < ApplicationController

    get '/' do
        if authorize_home
          return erb :home_loggedout
        end
        tweets = Tweet.order("created_at")
        if tweets.length <= 10
            @tweets= tweets.reverse
        else
            @tweets = tweet[tweets.length - 10, tweets.length].reverse
        end
        erb :"user/index"
    end

    get '/users/:user/tweets' do
        @user = User.find_by_slug(params[:user])
        erb :"user/tweets"
    end


    get '/users/:user' do
        @user = User.find_by_slug(params[:user])
        erb :"user/tweets"
    end



    get '/logout' do
        session.clear
        redirect '/login'
    end

end
