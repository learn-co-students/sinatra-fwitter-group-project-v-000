class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @user = User.find_by_id(session[:user_id])
            erb :'users/index'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/create_tweet'
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            @tweet = Tweet.create(:content => params[:content])
            @tweet.user = current_user
            @tweet.save
        else
            redirect "/tweets/new"
        end
    end
end