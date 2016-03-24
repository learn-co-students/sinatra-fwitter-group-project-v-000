class TweetController < ApplicationController

  get '/tweets' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    @user = User.find(session[:user_id])
    erb :tweets
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to '/tweets/new'
    end
    @tweet = Tweet.create(content:params[:content])
    @tweet.user_id = session[:user_id]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/new' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    erb :new_tweet
  end

  get '/tweets/:tweet_id' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:tweet_id])
    erb :'/tweets/show'
  end

  get '/tweets/:tweet_id/edit' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:tweet_id])
    erb :'/tweets/edit'
  end

  patch '/tweets/:tweet_id' do
    @tweet = Tweet.find_by_id(params[:tweet_id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:tweet_id/delete' do
    if !User.is_logged_in?(session)
      redirect to '/tweets'
    end
    @tweet = Tweet.find_by_id(params[:tweet_id])
    if User.current_user(session) == @tweet.user
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end