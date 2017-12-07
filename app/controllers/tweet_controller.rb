class TweetController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    end
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    if @tweet.save
      redirect to "/tweets"
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user == current_user
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}/edit"
    elsif logged_in?
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user == @tweet.user
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
