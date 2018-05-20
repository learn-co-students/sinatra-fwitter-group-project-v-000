class TweetsController < ApplicationController

  get '/tweets' do
    not_logged_in if !logged_in?
    @user = User.find(session[:user_id])
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    not_logged_in if !logged_in?
    erb :'tweets/new'
  end

  get '/tweets/:id/edit' do
    not_logged_in if !logged_in?
    @tweet = current_user.tweets.find_by_id(params[:id])
    not_your_tweet if !@tweet
    erb :'tweets/edit'
  end

  post '/tweets' do
    invalid_tweet_new if !valid_tweet?(params)
    current_user.tweets.build(params)
    current_user.save
    redirect '/tweets'
  end

  get '/tweets/:id' do
    not_logged_in if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end
  # Add below code to show page to hide edit and deltet if not current user's post
  # <%if current_user.tweets.find_by_id(@tweet.id)%>
  #   edit and delete button
  #  <%end%>

  patch '/tweets/:id' do
    invalid_tweet_edit(params) if !valid_tweet?(params)
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    erb :'tweets/show'
  end

  delete '/tweets/:id' do
    @tweet = current_user.tweets.find_by_id(params[:id])
    not_your_tweet if !@tweet
    @tweet.delete
    redirect '/tweets'
  end

end
