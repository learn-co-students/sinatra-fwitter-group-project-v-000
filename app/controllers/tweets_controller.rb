class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/tweets'
          else
            redirect to '/login'
          end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end  
    end

    post '/tweets' do 
        tweet = Tweet.create(content: params[:content])
        tweet.user = current_user
        tweet.save
        redirect to '/tweets'
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if  @tweet && current_user == @tweet.user
                erb :'tweets/show' 
            else
                redirect to '/tweets'
            end
        else
            redirect to '/'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])
        erb :'tweets/edit'
    end

    patch '/tweets/:id' do 
        tweet = Tweet.find(params[:id])
        tweet.update(content: params[:content])
        redirect to "/tweets/#{params[:id]}"
    end

    delete '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        tweet.delete
        redirect to '/tweets'
    end

end
