class TweetsController < ApplicationController
  use Rack::Flash

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :"/tweets/index"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    user = current_user
    if !params["tweet"]["content"].empty?
      tweet = user.tweets.create(params[:tweet])
      redirect to "/tweets/#{tweet.id}"
    else

    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      if current_user.tweets.include?(Tweet.find(params[:id]))
        @tweet = Tweet.find(params[:id])
        erb :"/tweets/edit"
      else
        flash[:message] = "You can only edit your own tweets"
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.update(params[:tweet])
    redirect to "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect to "/tweets"
  end
end
