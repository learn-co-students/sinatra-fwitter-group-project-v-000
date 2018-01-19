class TweetsController < ApplicationController
  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    tweet = current_user.tweets.build(params[:tweet])

    if tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  delete '/tweets/:id' do
    tweet = current_user.tweets.find(params[:id])
    tweet.destroy
    redirect '/tweets'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end
  
  patch '/tweets/:id' do
    tweet = current_user.tweets.find(params[:id])
    if tweet.update(params[:tweet])
      redirect '/tweets'
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  error ActiveRecord::RecordNotFound do
    [404, "Tweet not found"]
  end
end