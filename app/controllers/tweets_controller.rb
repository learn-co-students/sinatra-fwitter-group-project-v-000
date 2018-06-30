class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

    get '/tweets/new' do
      if logged_in?
        erb :'/tweets/create_tweet'
      else
        redirect to "/login"
      end
    end



    get '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/tweets'
    end

    get '/tweets/:id/edit' do
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    end

    post '/tweets/:id' do
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content] != ""
        @tweet.(:content => params[:content])
        reditect to "/tweets/#{@tweet.id}"
      else
        reditect to "/tweets/#{@tweet.id}/edit"
      end

    end

    delete '/tweets/:id' do
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      reditect to '/tweets'
    end

end
