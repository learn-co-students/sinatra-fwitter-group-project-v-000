class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(content: params[:content], user: current_user)
    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = current_user.tweets.find_by_id(params[:id])
      if @tweet
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = current_user.tweets.find_by_id(params[:id])
    if tweet
      tweet.content = params[:content]
      if tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect "/tweets/#{tweet.id}/edit"
      end
    else
      redirect '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = current_user.tweets.find_by_id(params[:id])
      tweet.destroy if tweet
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
