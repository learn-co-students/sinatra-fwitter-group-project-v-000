class TweetsController < ApplicationController

    get '/tweets' do
        authorize #added for tests
        @tweets = Tweet.all.reverse
        erb :"tweet/index"
    end

    get '/tweets/new' do
        authorize
        erb :"tweet/new"
    end


    get '/tweets/:id' do
      authorize #added for tests
      if (@tweet = Tweet.find_by(id: params[:id]))
        erb :"tweet/show"
      else
        erb :failure
      end
    end

    get '/tweets/:id/edit' do
        authorize
        if ((@tweet = Tweet.find_by(id: params[:id])) && current_user.tweets.include?(@tweet))
            erb :"tweet/edit"
        else
            erb :failure
        end
    end

    patch '/tweets/:id' do
        authorize
        if ((@tweet = Tweet.find_by(id: params[:id])) && current_user.tweets.include?(@tweet))

            if @tweet.update(params[:tweet])
                redirect "/tweets/#{@tweet.id}"
            else
              redirect "/tweets/#{@tweet.id}/edit" #added for tests
                # erb :failure
            end
        else
            erb :failure
        end
    end

    post '/tweets' do
        authorize
        tweet = Tweet.new(params[:tweet])
        tweet.user = current_user
        if tweet.save
            redirect '/'
        else
          redirect '/tweets/new' #added for test
            # erb :failure
        end
    end


    post '/tweets/:tweet_id/like' do
        authorize
        current_user.liked_tweets << @tweet if ((@tweet = Tweet.find_by(id: params[:tweet_id])) && !@tweet.user_likes.include?(current_user))
        redirect "/tweets/#{params[:tweet_id]}"
    end


    delete '/tweets/:id/delete' do
      if ((@tweet = Tweet.find_by(id: params[:id])) && current_user.tweets.include?(@tweet))
        @tweet.delete
        redirect '/tweets'
      else
        erb :failure
      end
    end
end
