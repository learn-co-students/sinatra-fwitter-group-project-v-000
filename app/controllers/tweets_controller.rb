class TweetsController < ApplicationController

    get '/tweets' do
        redirect to '/login' unless logged_in?
        @user = current_user
        @tweets = Tweet.all
        erb :'tweets/tweet'
    end

end
