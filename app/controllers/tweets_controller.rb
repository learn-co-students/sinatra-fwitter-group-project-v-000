class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = current_user.tweets.create(content: params[:content])
    if logged_in? && tweet.save
      @tweet = current_user.tweets.last
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = current_user.tweets.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = current_user.tweets.find(params[:id])
    if logged_in? & @tweet.update(content: params[:content])

      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if logged_in? & current_user.tweets.include?(tweet)
      tweet.destroy

    end
    redirect to '/tweets'
  end

end
