class TweetsController < ApplicationController

    get '/tweets' do
        @user = User.find_by(id: session[:user_id])
        erb :'/tweets/index'
    end
    
end