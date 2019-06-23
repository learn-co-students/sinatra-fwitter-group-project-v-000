class TweetsController < ApplicationController

    get '/tweets' do
        @user = User.find_by(id: session[:user_id])
        # binding.pry
        if !@user.nil?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
          redirect '/login'
        end
    end
    
end