class TweetsController < ApplicationController

  get '/tweets' do
    redirect to '/login' unless is_logged_in?(session)
    @user = current_user(session)
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    redirect to '/login' unless is_logged_in?(session)
    erb :'tweets/create_tweet'
  end

  get '/tweets/:id' do
    redirect to 'login' unless is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    redirect to 'login' unless is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets' do
    redirect to '/tweets/new' if params[:content].empty?
    user = User.find(session[:user_id])
    user.tweets.create(content: params[:content])
    redirect '/tweets'
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    redirect to "/tweets/#{tweet.id}/edit" if params[:content].empty?
    tweet.update(content: params[:content])
    redirect "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    redirect to "/tweets/#{tweet.id}" unless current_user(session) == tweet.user
    tweet.destroy
    redirect "/tweets"
  end
end
