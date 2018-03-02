class TweetsController < ApplicationController

    get '/tweets' do
      if logged_in?
        @user = get_user_by_session
        erb :'/tweets/tweets'
      else
        redirect to '/login'
      end
    end

    get '/tweets/new' do
      if logged_in?
        @user = get_user_by_session
        erb :'/tweets/create_tweet'
      else
        redirect to '/login'
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = get_tweet_by_id(params[:id])
        erb :'/tweets/edit_tweet'
      else
        redirect to '/login'
      end
    end

    get '/tweets/:id' do
      @tweet = get_tweet_by_id(params[:id])
      if logged_in?
        erb :'/tweets/show_tweet'
      else
        redirect to '/login'
      end
    end

    post '/tweets/new' do
      if !logged_in?
        redirect to '/login'
      elsif !params[:content].empty?
        @tweet = Tweet.create(content: params[:content], user_id: get_user_by_session.id)
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to '/tweets/new'
      end
    end

    post '/tweets/:id/edit' do
      @tweet = get_tweet_by_id(params[:id])
      redirect to '/tweets/#{@tweet.id}/edit'
    end

    patch '/tweets/:id/edit' do
      if !params[:content].empty?
        @tweet = get_tweet_by_id(params[:id])
        @tweet.update(content: params[:content])
      end
      redirect to "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id/delete' do
      @tweet = get_tweet_by_id(params[:id])
      if logged_in? && same_user?(@tweet)
        @tweet.delete
        redirect to "/tweets"
      else
        redirect to '/login'
      end
    end

end
