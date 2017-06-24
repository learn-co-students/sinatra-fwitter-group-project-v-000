class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/create_tweet'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      # binding.pry
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.new(params[:tweet])
    if @tweet.valid?
      @tweet.save
      redirect "tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.assign_attributes(params[:tweet])
    if @tweet.valid?
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    end
  end

end
