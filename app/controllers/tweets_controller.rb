class TweetsController < ApplicationController

    get '/tweets' do
        @user = User.find_by(id: session[:user_id])
        # binding.pry
        if !@user.nil?
            erb :'/tweets/index'
        else
          redirect '/login'
        end
    end
    
end