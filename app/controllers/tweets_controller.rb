class TweetsController < ApplicationController
  get '/tweets' do
    logged_in? ? erb(:"tweet/list") : redirect('/login')
  end

  post '/tweets' do
    redirect('/login') unless logged_in?
    tweet = current_user.tweets.build(content: params[:content])
    tweet.save ? redirect('/tweets') : redirect('/tweets/new')
  end

  get '/tweets/new' do
    logged_in? ? erb(:"tweet/new") : redirect('/login')
  end

  get '/tweets/:tweet_id' do
    redirect('/login') unless logged_in?
    @tweet = Tweet.find(params[:tweet_id])
    erb :"tweet/show"
  end

  delete '/tweets/:tweet_id/delete' do
    redirect('/login') unless logged_in?
    tweet = Tweet.find(params[:tweet_id])
    tweet.delete if tweet.user == current_user
    redirect('/tweets')
  end

  get '/tweets/:tweet_id/edit' do
    redirect('/login') unless logged_in?
    @tweet = Tweet.find(params[:tweet_id])
    @tweet.user == current_user ? erb(:"tweet/edit") : redirect('/tweets')
  end

  post '/tweets/:tweet_id/edit' do
    tweet = Tweet.find(params[:tweet_id])
    redirect "/tweets/#{tweet.id}/edit" if params[:content] == ""
    tweet.update(content: params[:content])
    redirect "/tweets/#{tweet.id}"
  end
end
