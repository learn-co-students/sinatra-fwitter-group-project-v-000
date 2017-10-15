class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] != ""
      tweet = Tweet.create(:content => params[:content])
      current_user.tweets << tweet
      redirect to "/tweets"
    else
      @tweet_error = true
      erb :"/tweets/create_tweet"
    end
  end

    get '/tweets/:id' do
      @tweet ||= Tweet.find_by_id(params[:id])

      if logged_in? && @tweet && current_user == @tweet.user
        erb :"/tweets/show_tweet"
      else
        redirect to "/login"
      end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && current_user.id == @tweet.user_id
      erb :"/tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if @tweet && params[:content] != ""
      @tweet.update_attribute(:content, params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])

    if current_user.id == tweet.user_id && logged_in?
      tweet.destroy
      redirect to "/tweets"
    else
      redirect to "/tweets"
    end
  end

end
