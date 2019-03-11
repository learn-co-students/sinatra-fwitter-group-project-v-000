class TweetsController < ApplicationController

#index action. index page to display all tweets
    get '/tweets' do
        if logged_in?
            @user = current_user
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end
#create
#new action. displays create tweet form
    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect to '/login'
        end
    end
#create action. Creates one tweet.
    post '/tweets' do
        if params[:content] != ""
            @tweet = current_user.tweets.create(params)
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to '/tweets/new'
        end
    end

#Read
    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

#update

    get '/tweets/:id/edit' do
        #binding.pry
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet.user.username == current_user.username
                erb :"/tweets/edit_tweet"
            else
                redirect to "/tweets/#{@tweet.id}"
            end
            #redirect to '/tweets/edit_tweet'
        else
            redirect to '/login'
        end
    end


    patch '/tweets/:id' do
        #binding.pry
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if params[:content] != ""
                @tweet.update(content: params[:content], user_id: current_user.id)
                redirect to "/tweets/#{@tweet.id}"
            else
                redirect to "/tweets/#{@tweet.id}/edit"
            end
        end
    end

#delete action
    delete '/tweets/:id/delete' do
        if logged_in?
        @tweet = Tweet.find_by(params[:id])
            if @tweet.user == current_user
                @tweet.delete
                redirect to '/tweets'
            else
                redirect to "/tweets"
            end
        end
    end

end
