class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content])
    if tweet.save
      user = User.find_by(session[:user_id])
      user.tweets << tweet
      redirect to "/tweets/#{tweet.id}"
    else
      flash[:message] = "At least say 'hello!' An empty tweet is pretty boring. :)"
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    tweet[:content] = params[:content]
    if tweet.save
      redirect to "/tweets/#{tweet.id}"
    else
      flash[:message] = "At least say 'hello!' An empty tweet is pretty boring. :)"
      redirect to "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in? && current_user.tweets.include?(@tweet)
      @tweet.delete
      redirect to '/tweets'
    end
  end

end