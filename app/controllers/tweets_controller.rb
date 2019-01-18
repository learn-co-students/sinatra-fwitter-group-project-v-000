class TweetsController < ApplicationController
    #This controlled will control all tweet actions/routes.

    get '/' do
        erb :'/index'
    end
    
      #loads the signup page
    get '/signup' do
        erb :'/users/create_user'
    end
    
    post '/signup' do
        erb :'/tweets'
    end
    
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = User.find_by(params[:username])
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end

    post '/tweets/tweets' do
        @tweets = Tweet.all
        redirect to '/tweets'
    end

    get 'tweets/new' do

        erb :'/tweets/new'
    end

end
