class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets_index'
    else redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/tweets_new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params["content"] != ""
      @tweet = Tweet.create(content: params["content"])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params["id"])
      erb :'tweets/tweets_show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params["id"])

      erb :'tweets/tweets_edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params["id"])

    if params["content"] != ""
      @tweet.content = params["content"]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params["id"])
    if logged_in?
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end
end
