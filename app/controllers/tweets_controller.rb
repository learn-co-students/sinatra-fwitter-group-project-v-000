class TweetsController < ApplicationController

  get '/tweets', :auth => :logged_in? do
    erb :'tweets/tweets'
  end

  get '/tweets/new', :auth => :logged_in? do
    erb :'tweets/create_tweet'
  end

  get '/tweets/:id', :auth => :logged_in? do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit', :auth => :logged_in? do
    @tweet = Tweet.find(params[:id])

    if @tweet.user == current_user
      erb :'tweets/edit_tweet'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.create(content: params[:content])
    redirect @tweet.valid? ? "/tweets/#{@tweet.id}" : "/tweets/new"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect @tweet.valid? ? "/tweets/#{@tweet.id}" : "/tweets/#{params[:id]}/edit"
  end

  delete '/tweets/:id/delete', :auth => :logged_in? do
    @tweet = Tweet.find(params[:id])

    if @tweet.user == current_user
      @tweet.destroy
      erb :'tweets/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

end
