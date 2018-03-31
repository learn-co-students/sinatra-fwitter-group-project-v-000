class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @tweets = Tweet.all
      erb :'/tweets/index'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to 'tweets/new'
    else
      @tweet = current_user.tweets.build(params)
      current_user.save
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      if current_tweet
        erb :'/tweets/edit'
      else
        redirect to '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    if current_tweet
      if params[:content] == ""
        redirect to "tweets/#{current_tweet.id}/edit"
      else
        current_tweet.update(content: params[:content])
        redirect to "/tweets/#{current_tweet.id}"
      end
    else
      redirect to '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    if current_tweet
      current_tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
