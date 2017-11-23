class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
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
    if !params[:content].empty?
      @tweet = current_user.tweets.create(params)
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/new"
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
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id != current_user.id
        redirect to "/tweets"
      else
        erb :"/tweets/edit"
      end
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.destroy
    end
    redirect "/tweets"
  end
end
