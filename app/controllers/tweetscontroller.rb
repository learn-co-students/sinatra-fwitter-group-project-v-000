class TweetsController < ApplicationController

    

    # get '/show' do
    #     @tweets = Tweet.all
    #     erb :'/show'
    # end

    get '/tweets/new' do
        if logged_in?
             erb :'tweets/new'
        else # logged out and doesn't let them view the create tweet

        redirect to "/login"
        end
    end

     post '/tweets' do
        if params[:content] == "" #blank tweet
            redirect to "/tweets/new"
        else
             @tweet = current_user.tweets.create(content: params[:content])
             redirect to "/tweets/#{@tweet.id}"
        end
    end


    get '/users/:slug' do
        @tweets = Tweet.all
        erb :'/tweets'
    end

    get '/tweets/:id' do
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :"/tweets/show"
        else
        redirect to '/login'
        end
    end

   

    get '/tweets/:id/edit' do
        if logged_in?
        @tweet = Tweet.find_by(params[:id])
           erb :"/tweets/edit"
           else
        redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
            if params[:content] == ""
                redirect to "/tweets/#{@tweet.id}/edit"
            else
                @tweet.save

              redirect to "/tweets/#{@tweet.id}/edit"
            end
         else
        redirect to "/login"
        end
    end
 

    delete '/tweets/:id/delete' do
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user_id == current_user.id
        @tweet.delete
                redirect to '/tweets'
        else
        redirect to '/tweets'
            end
        else
            redirect '/login'
        end

    end
end