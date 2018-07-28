class TweetsController < ApplicationController
    get '/tweets/new' do #create view
        if session[:user_id]
            erb :'tweets/create_tweet'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do #create action
        @user = User.find_by(session[:user_id])
        @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)

        redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
        if session[:user_id]
            @tweet = Tweet.find_by(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if session[:user_id]
            @tweet = Tweet.find_by(params[:id])
            erb :'tweets/edit_tweet'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save

        redirect to "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.delete

        redirect to '/tweets'
    end
end
