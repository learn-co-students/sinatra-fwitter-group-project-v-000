class TweetsController < ApplicationController
    get '/tweets' do
        @user = User.find_by(session[:id])
        if @user
            erb :"tweets/tweets"    
        else
            redirect to '/login'
        end
    end

end
