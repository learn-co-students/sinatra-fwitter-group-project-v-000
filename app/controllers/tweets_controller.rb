class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
      current_user.tweets.create(content: params[:content])
      redirect to '/tweets'
  end

  get '/tweets/:id' do
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if current_user.id == @tweet.user_id
        erb :'/tweets/edit_tweet'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
      @tweet = current_user.tweets.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = current_user.tweets.find_by_id(params[:id])
      if @tweet && @tweet.destroy
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end



end
