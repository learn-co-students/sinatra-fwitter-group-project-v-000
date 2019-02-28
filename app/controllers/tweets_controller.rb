class TweetsController < ApplicationController

#index action. index page to display all tweets
    get '/tweets' do
        if logged_in?
            #@user = User.find_by_id(session[:user_id])
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end
#create
#new action. displays create tweet form
    get '/tweets/new' do

    end

#create action. Creates one tweet.
    post '/tweets' do

    end

#Read
    get '/tweets/:id' do

    end

#update

    get 'tweets/:id/edit' do

    end

    patch 'tweets/:id' do

    end

#delete
    delete 'tweets/:id' do

    end


end
